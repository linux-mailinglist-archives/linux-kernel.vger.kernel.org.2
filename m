Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFDF435635
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 00:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhJTW62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 18:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJTW61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 18:58:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325E0C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 15:56:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id t184so4251346pfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 15:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=auquH8aadeMeFk2cOQm3PXeVysXe/4pxPSsJvPgzUtM=;
        b=L8Ies30D2Yzu308zJNAoks8R5bQl3xQGRZZlt1tbTCmOcIDIK2/ojqO2sO7DaOA+xW
         vbEcI/oqfw8dHounLNbaS0OuCcpohNzj0vV7TtmSGtcn6s1jNbwb5AAj8FBPtPl0r2tr
         Bd/Z3stzHp6fxDtLxDrGuLlf6gD4gMrXqk5pfW8qZYRG5ScyFvgRIHGS/f5VC6xfYABk
         x4rFiyVnEg+P1jD8pVVo7R+IaSd5TrPnyOzy8PlVbZgh/9LChQGzsDU730b58BfzXHk3
         RlAFWphMlFpLxThXiveYul1xMoQM+99xE80qRDl/+YXom32CltFTY5FcXeeKI/vQM3CE
         EXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=auquH8aadeMeFk2cOQm3PXeVysXe/4pxPSsJvPgzUtM=;
        b=2omM7kkkstvoUFBRvciMBXbpgf24PPiN9D33gIjWiD3k0OZ+X8bx0TNVqYLj85liGC
         9De4ckiA2MhupfMQoFwFWYxtuCbd4/EqycllW0HvXM4WY+kNQhwSj4Mjd2Ms/iMc6Wpu
         3wQtXSp6wC/3DYz4+1cmY2TqZLtKRlIHhvTc3e97xmIlSXVZmWA5X8z9ay/ee47Xj7B0
         bRiSj1ZruhF4HVyRHH2K4WWyH6TuCunMEc9qNf2+chqg4G8mPP+J5OV8fOtNo+1fYIrV
         bW6CfVFbqS0DWjKchE5yp9OZIRSEi6QEh2K3fkfDldDRW2MPShn6ghBSZ2Y7yTypL/78
         eMIw==
X-Gm-Message-State: AOAM531lnTZAG1tIUw5Fb6zKc4NnW0Ai0FFjFnUVlQpU7demD+RiS+9q
        Akizl9rlyhkYyrd8BpeWiWDjbU8bpkI=
X-Google-Smtp-Source: ABdhPJz1CX9DgO/7KLEfH8EhIgKn8/qPy4/h/VhladWn6mEWVE1c8mcFnSApklQQ4N9uMLeUWlM/MQ==
X-Received: by 2002:aa7:8f28:0:b0:44c:f281:c261 with SMTP id y8-20020aa78f28000000b0044cf281c261mr2071553pfr.76.1634770571645;
        Wed, 20 Oct 2021 15:56:11 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s62sm3333393pgc.5.2021.10.20.15.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 15:56:10 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: Re: [PATCH] soc: bcm: brcmstb: Add of_node_put() in pm-mips
Date:   Wed, 20 Oct 2021 15:56:09 -0700
Message-Id: <20211020225609.3144238-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015064958.9826-1-wanjiabing@vivo.com>
References: <20211015064958.9826-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 02:49:23 -0400, Wan Jiabing <wanjiabing@vivo.com> wrote:
> Fix following coccicheck warning:
> ./drivers/soc/bcm/brcmstb/pm/pm-mips.c:404:1-23: WARNING: Function
> for_each_matching_node should have of_node_put() before goto or break
> 
> Early exits from for_each_matching_node should decrement the
> node reference counter.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
