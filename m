Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7883E3E982D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhHKTBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhHKTBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:01:50 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0ECC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 12:01:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t3so3904524plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 12:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OTFJ+n7fIHLXueeBpA+yXPCbr6ZAaIT3IazZuu+1kpU=;
        b=OAg9I2lgUp0otUllgiqWgLE8zqpnjFc/a91iEPzQdNx13y00CfYJmGhfYFPpOrDXUt
         sgi2e+E+KQv7ZNcRAepQaMla+l+5WWA2RnOtSmEOZr5q2CnrMfE1keP1ETqXqfMQ4fzu
         7ocE0bBtFUyfC/utC5e/z4rVu3W3a0gkmuriU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTFJ+n7fIHLXueeBpA+yXPCbr6ZAaIT3IazZuu+1kpU=;
        b=TnKaBBsCrvxZtJVW3wAkR8ONL6ajSVNFzbICSFrtygQSlgrFtFcI/bSwBLfKeEcqJR
         QNEWSIx4tw0pVi0TavczA/96jH85ac//afzjXtZyd7xBwFFo1B/PabK5u3Fe8B1NMxZr
         xf7XM6VilDzj4eowwkolk0gvBkXehoyxWcqJCDJf+qClCDxz7lnEzlZLbbZ/lc7EQ1Dj
         bsLez19InSux++Nkn8/Nf/vceRvhWyYNRzp8XEShN5vt+DSNuIGxuUSgjN2qMqWSWi7P
         S54brToicWlMXkt19ftPrlzwujJMgjO4Cw7wmkpzwcpXBUrwSf3aW9pb5Bzd10CE2B7p
         0QrQ==
X-Gm-Message-State: AOAM530dWYgdTgigOVOtvn+zdqtSCEI/4+B9uMYxCS0Lxq0LFk3/0HEf
        DZWkUnB4JiuF1XWOz0lIwgIRrA==
X-Google-Smtp-Source: ABdhPJwPkXKpQPJdlBw3eLUpFe+B8kl97VdGUiw/umJfv6wbhLvWzRqNnyv59k5mMiCDrW+G8wHZCw==
X-Received: by 2002:a17:90b:3604:: with SMTP id ml4mr11973490pjb.82.1628708486364;
        Wed, 11 Aug 2021 12:01:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t22sm226816pgv.35.2021.08.11.12.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:01:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Hsuan-Chi Kuo <hsuanchikuo@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Wiktor Garbacz <wiktorg@google.com>
Subject: Re: [PATCH] seccomp: Fix resetting filter count at seccomp_sync_threads()
Date:   Wed, 11 Aug 2021 12:00:58 -0700
Message-Id: <162870845345.889227.3091837697085716524.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210304233708.420597-1-hsuanchikuo@gmail.com>
References: <20210304233708.420597-1-hsuanchikuo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2021 17:37:08 -0600, Hsuan-Chi Kuo wrote:
> The desired behavior is to set the caller's filter count to thread's.

Applied to for-next/seccomp, thanks!

[1/1] seccomp: Fix resetting filter count at seccomp_sync_threads()
      https://git.kernel.org/kees/c/b4d8a58f8dcf

-- 
Kees Cook

