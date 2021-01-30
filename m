Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3961C3090C0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 00:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhA2XtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 18:49:16 -0500
Received: from so15.mailgun.net ([198.61.254.15]:54473 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232045AbhA2XtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 18:49:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611964127; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=HUNiHIQmr/npCagMU/t/LtTySsZ+JNwCBw3sxHTxVDE=; b=BRPPy0p04bklfh53f9Xcir+dqGcNjoU2IiiwdDzox3iAm/zwWL3FsvbpTOu9XdVUeE3uRKQR
 MRd9n3Y0EilIE7uc+icKf9feeZ1c1NBbQrlIv4H5FpJQ5qvQTTVPbALGhT1x/hH8WnNwhsj6
 CXRoviYvYlv8TWxx3nYafPLc9JA=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60149ec04ee30634eb209d92 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 Jan 2021 23:48:16
 GMT
Sender: jcrouse=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1AA0CC43462; Fri, 29 Jan 2021 23:48:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 53D46C433C6;
        Fri, 29 Jan 2021 23:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53D46C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jcrouse@codeaurora.org
Date:   Fri, 29 Jan 2021 16:48:11 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Eric Anholt <eric@anholt.net>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/msm: Fix race of GPU init vs timestamp power
 management.
Message-ID: <20210129234811.GA1612@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <20210127233946.1286386-1-eric@anholt.net>
 <20210128184702.GB29306@jcrouse1-lnx.qualcomm.com>
 <CADaigPVF=Ti4tLYTUsK+0Gi6GbK9ADOuFf4tCYftmVZ96gJLxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADaigPVF=Ti4tLYTUsK+0Gi6GbK9ADOuFf4tCYftmVZ96gJLxg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 11:17:16AM -0800, Eric Anholt wrote:
> On Thu, Jan 28, 2021 at 10:52 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > On Wed, Jan 27, 2021 at 03:39:44PM -0800, Eric Anholt wrote:
> > > We were using the same force-poweron bit in the two codepaths, so they
> > > could race to have one of them lose GPU power early.
> > >
> > > Signed-off-by: Eric Anholt <eric@anholt.net>
> > > Cc: stable@vger.kernel.org # v5.9
> >
> > You can add:
> > Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
> >
> > Because that was my ugly.
> >
> > Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
> 
> I only pointed it at 5.9 because it looked like it would probably
> conflict against older branches.  I can add the fixes tag if you'd
> like, though.

Fair enough. It is a good bug to fix but not if there are a lot of conflicts to
deal with.

Jordan
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
