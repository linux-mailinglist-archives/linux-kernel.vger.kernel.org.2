Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B610142FA14
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242382AbhJORZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242279AbhJORYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:24:41 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3C0C0613E9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:22 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id z126so13995930oiz.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kn035h2h7OainpjhIOJkuHEQG/3BQcpVjhttGSsQ5lY=;
        b=cNbPYnwaihUZcstNAa3Q8Z9qG63pLORlJ4IIJ4NrZFslU0URaOqJzC68x0oXxa6M8G
         S7RqmU165kKJCKLivy/f7zaMNePPn9CF4dBHIS6UoeWDvbKjWOPaEOWOKrussZd3kcTn
         9qxRbR8eMtjKWwHBIK5lydn474w4XfYdO4Xbmnn9Jj4Th06Skx7fqn0o1yS9BdD7FGOr
         OZCKKKnzGvvc/iBSk8+YtjpbwR3OKXCOAfGQ3LpmME13NJ6HpFSpeRHsdJVUVNdomhqr
         RTWZxdMrt31LGTSi0gGaNVMDgAOPchq7ItXhHqrZ5urplXUq+mmC2RvOSoO0oS92EB00
         q0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kn035h2h7OainpjhIOJkuHEQG/3BQcpVjhttGSsQ5lY=;
        b=PvFEND5E8np45snuKmSrv/UghBJeVUgDrqElBKdgw18sEEICkIWQj+HBvK+CAUodAX
         +K0LfGMFXGQRW3UE4nIXOMAJ8LhzlXs2bVX0OHmbTu7gmJ0dPu5C2KvD3Yn2i0qnZ8V5
         UA+pZU1p94rC7T8WYpw+Bz/IJZjDmhfBZIEiNJ6xjG+o7uSUoa37Z/5h2SvnkUBVrj+Z
         FLDA50vRLoPOptNmjyrxA/5EOheDUoi+YAzLSecwVTJXsmLbW5Py97z3RbIef+zr85ZU
         CUXbo21tqFmW8rahL45evW0ELiCJn3peogJfwIUDsfzwWymsC3XQVTMqeTkUZCqs8mno
         sX2Q==
X-Gm-Message-State: AOAM531k1f6k50uKeoaNvwwEWgep5Pp9U0LItupWb9DilJ9V7Pf7/sUV
        Ub3rfk5elj89s9xLmmnd3KqcCw==
X-Google-Smtp-Source: ABdhPJzwWhzy6WbJsYDhzxEfmDkh5AS02JM1swhhP7BQQ6Yy40mssZMRIGxNWjpw+edJAuUba+Qq0Q==
X-Received: by 2002:aca:31cb:: with SMTP id x194mr9065981oix.62.1634318541580;
        Fri, 15 Oct 2021 10:22:21 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s206sm1289635oia.33.2021.10.15.10.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:22:21 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-remoteproc@vger.kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, ohad@wizery.com
Subject: Re: (subset) [PATCH] rpmsg: virtio_rpmsg_bus: use dev_warn_ratelimited for msg with no recipient
Date:   Fri, 15 Oct 2021 12:22:11 -0500
Message-Id: <163431847249.251657.14318070170009909364.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210928132902.1594277-1-aardelean@deviqon.com>
References: <20210928132902.1594277-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 16:29:02 +0300, Alexandru Ardelean wrote:
> From: Alexandru Ardelean <ardeleanalex@gmail.com>
> 
> Even though it may be user-space's fault for this error (some application
> terminated or crashed without cleaning up it's endpoint), the rpmsg
> communication should not overflow the syslog with too many messages.
> 
> A dev_warn_ratelimited() seems like a good alternative in case this can
> occur.
> 
> [...]

Applied, thanks!

[1/1] rpmsg: virtio_rpmsg_bus: use dev_warn_ratelimited for msg with no recipient
      commit: 63b8d79916672d35069962d87d1540c534cb2438

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
