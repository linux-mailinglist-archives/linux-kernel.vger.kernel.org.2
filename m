Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482E93C182E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhGHRfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:35:51 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:48793 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhGHRfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:35:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625765589; h=Content-Transfer-Encoding: Mime-Version:
 Content-Type: References: In-Reply-To: Date: Cc: To: From: Subject:
 Message-ID: Sender; bh=gJdLAU5Uhao+hus0LMO748o8+xshJ3r9MDcn1bVd+O8=; b=F3oJlw+iDt9gz98Jm/+bz0hZ5hkTtFJ+Qm63J79LU/cvgSWF1EfjaLNvl877X0f4lphl+M3T
 d8H7kG8+KW25OaHkxL+R9mh09mPyH+2qbeN5sHQoQ7WmBuMqLrOGBnG8O0i4rAfTKcDUfGa+
 p81dcRKUvzD8z9fE4l4tvbIGFcI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60e736cf638039e997a28ab0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Jul 2021 17:33:03
 GMT
Sender: hemantk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0BDADC433D3; Thu,  8 Jul 2021 17:33:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hemantk-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34B1DC433F1;
        Thu,  8 Jul 2021 17:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34B1DC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=hemantk@codeaurora.org
Message-ID: <1625765577.10055.24.camel@codeaurora.org>
Subject: Re: [PATCH] bus: mhi: pci_generic: Simplify code and axe the use of
 a deprecated API
From:   Hemant Kumar <hemantk@codeaurora.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>, mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Thu, 08 Jul 2021 10:32:57 -0700
In-Reply-To: <bb3dc436fe142309a2334549db782c5ebb80a2be.1625718497.git.christophe.jaillet@wanadoo.fr>
References: <bb3dc436fe142309a2334549db782c5ebb80a2be.1625718497.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-07-08 at 06:30 +0200, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> Replace 'pci_set_dma_mask/pci_set_consistent_dma_mask' by an
> equivalent
> and less verbose 'dma_set_mask_and_coherent()' call.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>    https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> ---

Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

