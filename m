Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A61E42FA15
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242431AbhJORZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbhJORYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:24:42 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B6BC0613EC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:23 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id e63so14000152oif.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQGBuMylvu9UpPG16xaz7lVAENRpwI6V6j3bp4rN4V8=;
        b=Z32jp32n95zqUqhWkMrX4wuXD7gqEWBUoQ3lI3z+JPu9Fqs8D/TCdHv+/oKcxvuVsG
         5MY5DZtqjnWF45OCt8tP248VQrelq4DcFwkxYxGoVTrSToE2pBu0O0A0l0XVWNAN3fUG
         efgStWf1jtSTQp/PZpdavWMCawX29qpoDDGIaIRW+/soU9tgtY1BRlAkbEL0t6dhAk+t
         tWgdSnaMz4d9TWk166bIDJh2rApyQi8cTisbI8ueK6nyA3KDTjHFCzw/kI+XWq6torNd
         dg4vCsPgcBUuRrHxqxYrOPAMIheidts6ccxkhsuxY4Hl0wrvmGuY6We0/7bjZ2B5hzDW
         aRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQGBuMylvu9UpPG16xaz7lVAENRpwI6V6j3bp4rN4V8=;
        b=aJr6c1z1MLjcvx9Hl82+VWK6erSuK1f/XU2yfzHlULfnua4jF6QEuXeE55cBR920xI
         vQjiIQnukmR8mcMBld5lU8u426PPHdzDawBl+5UHuZ0JPB2KyWukLXLejVchpLSI/TnV
         lNPnwZoVBx3dUG3Kw/dVbDxEcp7ZZa9DmcxJu37frK1hSbhWI+HZUTnlg3vL9LIHlkra
         hFJOUEioMqBQd7O+SadZicThUfsovj1ffWqD72s9RXkPADSlMwQ7uuOI87IX8a8WgYHR
         8lLHW8FxAc+XeU1H8IDpjircE/EXlMjdBwVWAja/tnFU//6wQFNEqUWzQpG9+PcxmFpk
         L3UQ==
X-Gm-Message-State: AOAM533rvcU1ehPByqaAR7XB0bzkcb6JLJNrbgsn1+rTHHsFneoXCFgN
        kIsfVYLu+JcibV1E3c4CzOqILg==
X-Google-Smtp-Source: ABdhPJwa8s1a0Vpv49BVQ3zzH13cErd4RoRJClmYGmIqUl6vc5OL2TMuNEsVurpHsk1CKWr2KKNkXw==
X-Received: by 2002:a05:6808:1802:: with SMTP id bh2mr8031298oib.142.1634318542710;
        Fri, 15 Oct 2021 10:22:22 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s206sm1289635oia.33.2021.10.15.10.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:22:22 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh@kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Stefano Stabellini <stefanos@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Bruce Ashfield <bruce.ashfield@xilinx.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: (subset) [RFC PATCH 3/7] remoteproc: Remove vdev_to_rvdev and vdev_to_rproc from remoteproc API
Date:   Fri, 15 Oct 2021 12:22:12 -0500
Message-Id: <163431847249.251657.1509146684272045901.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211001101234.4247-4-arnaud.pouliquen@foss.st.com>
References: <20211001101234.4247-1-arnaud.pouliquen@foss.st.com> <20211001101234.4247-4-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2021 12:12:30 +0200, Arnaud Pouliquen wrote:
> These both functions are only used by the remoteproc_virtio.
> There is no reason to expose them in the API.
> Move the functions in remoteproc_virtio.c
> 
> 

Applied, thanks!

[3/7] remoteproc: Remove vdev_to_rvdev and vdev_to_rproc from remoteproc API
      commit: 9955548919c47a6987b40d90a30fd56bbc043e7b

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
