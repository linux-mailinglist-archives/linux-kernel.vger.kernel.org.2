Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF31A3D214F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhGVJPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:15:06 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:47980 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231271AbhGVJPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:15:04 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16M7GEwY021297;
        Thu, 22 Jul 2021 04:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=MFSYCskN+1QDzOxOKrFIg7/n0TUbqpFAwQmpyPlf204=;
 b=ENZHGPM/4OmP7uz+p5ph0NRhjU1PAdM2Tw0tMKZJ5gvZv0hH1IAJyLiIXdBwh0U5chi2
 JdWLXfnGJI6tVXQcmICQlR1YQd/24mn5K/H7YTan77OYi+Z26VCMlTaNPPtBFb5Fdgg1
 chpVGryIuFD4ERMr413KENCcL/osp7aNhizrMHWr8T8rdQ0JkU/plAXHsZH7+KOE45e6
 YLCeRW7LHf6N3Pp6ovAZ2pqkCQggHkhGuWNiwBF5Mlm++mzQaOqJgQO79w+wLtTScNoJ
 /9Ky9VJoWJ9s4lB23KHfZV/9nczJD4epPL2AhhSy2Bl7MSpB1bxfISVZdTYopsuL1jSi Bw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 39xgrt9cby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Jul 2021 04:55:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 10:55:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 22 Jul 2021 10:55:24 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.17])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 100B92BA;
        Thu, 22 Jul 2021 09:55:24 +0000 (UTC)
Subject: Re: [PATCH] ASoC: dapm: Revert "use component prefix when checking
 widget names"
To:     Mark Brown <broonie@kernel.org>
CC:     <pierre-louis.bossart@linux.intel.com>,
        <rander.wang@linux.intel.com>, <shumingf@realtek.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20210703125034.24655-1-rf@opensource.cirrus.com>
 <20210705165041.GC4574@sirena.org.uk>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <a882a9e0-db05-2f89-abb9-8b308ccb56c8@opensource.cirrus.com>
Date:   Thu, 22 Jul 2021 10:55:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705165041.GC4574@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XCW_dW3XhHisG8xyfLH0o6NIRjmT_Q9G
X-Proofpoint-ORIG-GUID: XCW_dW3XhHisG8xyfLH0o6NIRjmT_Q9G
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxlogscore=957 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107220066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2021 17:50, Mark Brown wrote:
> On Sat, Jul 03, 2021 at 01:50:34PM +0100, Richard Fitzgerald wrote:
> 
>> That commit breaks all users of the snd_soc_component_*_pin() functions
>> because it results in the prefix being added twice. It also breaks code
>> that correctly uses the snd_soc_dapm_*_pin() functions.
> 
>> Use the snd_soc_component_*_pin() functions if you want the component
>> prefix to be prepended automatically.
> 
>> Use the raw snd_soc_dapm_*_pin() functions if the caller has the full
>> name that should be matched exactly.
> 
> I'm not sure the analysis of which function to use when is correct or
> what we want here (though it will work ATM), though looking again more
> closely at the patch it doesn't look entirely right either.  The way
> this used to be done, and the way that older code will most likely
> assume things work, was that the DAPM functions would first try to match
> on the local DAPM context before falling back to doing a global match.
> This is what the fallback loop is intended to do, and the dapm functions
> are passing the "search other contexts" flag into dapm_find_widget().
> 
> I'd not expect the distinction you seem to expect between component and
> DAPM and we probably have a bunch of older drivers that aren't working
> correctly like the Realtek driver mentioned in the original fix.  I
> think what needs to happen is that dapm_find_widget() needs to be
> checking both the prefixed and non-prefixed names, and that the
> component stuff shouldn't need to bother and just be a convenience
> wrapper for users that happene to have a component to hand.
> Alternatively we need to do an audit of all the non-machine drivers to
> switch them to use the component functions exclusively (and possibly
> some of the machine drivers as well), most of the CODEC users look to be
> a small number of Wolfson/Cirrus ones.
> 

I don't mind if someone wants to change the core dapm functions if that
is generally useful, providing that it also updates all callers of those
functions to still work.

Changing the behaviour of core code to fix the Realtek driver without
updating other callers of those functions is a problem.
