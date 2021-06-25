Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6113D3B4007
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhFYJJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:09:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14730 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230526AbhFYJJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:09:13 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15P92VtW007281;
        Fri, 25 Jun 2021 09:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=NZWJv2xcbxD1nxp9+aq9ApwvBM61K+hAFTVm04AAlxo=;
 b=mAyiUL6gbde5gEqazg/Bxb72lclHE1OqXwJ/cwmheyBiiB0/RN8euYX2yyNTSgGGSd96
 8TahK6dXpafdic0+TC+ynCXU2D2rnsoqtPzxY2goj5iPaxTleZDkpmeTz2a70W2mP4yM
 TlZrjIFsDjDRqqDbtkD4AM/OhHBuCfUd35SIxfYDMofE1yan4QejDbnnjtrqfnUnv/+b
 4RndWtPkBZKlP29otGhBzoALNqB3nl/6cpiMufAToCiz7QCeBCmuUN0ifW2XO+rpnC4p
 lIjs3dxRQndUGKYFZjqjvHsQWnWmHh8+17V599PPDHLQFrTcNanUsRlrzrZ6vm0lD1dN mQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d24a8wxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 09:05:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15P8xajb119590;
        Fri, 25 Jun 2021 09:05:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 39d243702m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 09:05:58 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15P90xQ8124911;
        Fri, 25 Jun 2021 09:05:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 39d243701y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 09:05:57 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15P95l7J031960;
        Fri, 25 Jun 2021 09:05:52 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jun 2021 02:05:46 -0700
Date:   Fri, 25 Jun 2021 12:05:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        clemens@ladisch.de, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ALSA: firewire-lib: Fix 'amdtp_domain_start()' when no
 AMDTP_OUT_STREAM stream is found
Message-ID: <20210625090538.GG2040@kadam>
References: <9c9a53a4905984a570ba5672cbab84f2027dedc1.1624560484.git.christophe.jaillet@wanadoo.fr>
 <YNTzrtrmDBdg2ec6@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNTzrtrmDBdg2ec6@workstation>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: T9AK70S8GuSoI4Tm38q7WxPBlNMpYa3r
X-Proofpoint-ORIG-GUID: T9AK70S8GuSoI4Tm38q7WxPBlNMpYa3r
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 06:05:50AM +0900, Takashi Sakamoto wrote:
> 
> In kernel v5.10 or later, we can use 'list_entry_is_head()' macro added
> by a commit e130816164e2 ("include/linux/list.h: add a macro to test if
> entry is pointing to the head").

Someone needs to backport that all the way back...

regards,
dan carpenter

