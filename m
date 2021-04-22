Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742FB368989
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 01:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbhDVX5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 19:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbhDVX5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 19:57:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27E5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 16:56:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j5so45539500wrn.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 16:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ALCAFiUi51S3PIdvclw/G9XXE9DLJXb5Z0T/S+Z9JLs=;
        b=GCQef4VLrFhvFv+OgYmsX8RdjQi9ktkHCD0HZSwyqJ3r3j/C59nkSrJNpM/TcIeBnr
         wgQe5isVAX3vGx+VgaQcI24nNZYSDp8ropHT0fvNnEeSkMZNhAdYT8DQfrBa5csFCaRc
         xnCsqy8iB2xgonGjcrgVcFCz9zKi824RAgcVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ALCAFiUi51S3PIdvclw/G9XXE9DLJXb5Z0T/S+Z9JLs=;
        b=QWAEjhBlKQhIngDLL7k4pqNQVor/UMgnOEDKf4WaODljJVmTldVcHn6j0Xq/beU4pR
         Nybr4XbB5qZCMsDWO+68qMpio3p6rqNWPxcyZR6sdY3v+thnrxUsyCNg3uVscW9otLJV
         HUtqFytZv+guH9RCZlKmxLaPztePOER9L6KvnQKFmBq9xXkEaUD+ehu0p5SFYfM50rXf
         OQlRYdvw/5mm7GBe4+L+KrxOL0QvWaHeQ0XQwRjmUjag3beqAVj+YgWOLK5D08v7Swpw
         1ReK5SarVp6c2UI/xBv+P8s9z+cGqHcto9ehjclrnixEPtbDkcscqk9uwAit5BB5WwvF
         YzAg==
X-Gm-Message-State: AOAM531eUIRmJZAGs0EmNgBpOVPKKYK9xei0ANZsaS2M0qyPGjF7HxI4
        2boLb/Abmf43xm+14ju7aWTtXQ==
X-Google-Smtp-Source: ABdhPJzMo+/+ZyfE2xB1HTD087GbozYxjaAyTKEQlbzim1QNxtKOFGYbyUGAPajN3IM3w8hQ9wHf1w==
X-Received: by 2002:adf:de08:: with SMTP id b8mr915225wrm.279.1619135785413;
        Thu, 22 Apr 2021 16:56:25 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:e4b7:67ca:7609:a533])
        by smtp.gmail.com with ESMTPSA id t20sm8201149wmi.35.2021.04.22.16.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 16:56:25 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 0/2] Simplify bpf_snprintf verifier code
Date:   Fri, 23 Apr 2021 01:55:41 +0200
Message-Id: <20210422235543.4007694-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexei requested a couple of cleanups to the bpf_snprintf and
ARG_PTR_TO_CONST_STR verifier code.

https://lore.kernel.org/bpf/CABRcYmL_SMT80UTyV98bRsOzW0wBd1sZcYUpTrcOAV+9m+YoWQ@mail.gmail.com/T/#t

Florent Revest (2):
  bpf: Notify user if we ever hit a bpf_snprintf verifier bug
  bpf: Remove unnecessary map checks for ARG_PTR_TO_CONST_STR

 kernel/bpf/verifier.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.31.1.498.g6c1eba8ee3d-goog

