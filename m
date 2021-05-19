Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C698388BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348049AbhESKba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:31:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28582 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232734AbhESKb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:31:27 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JAR99p027400;
        Wed, 19 May 2021 10:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=h2fVCr69S9gKgle0Yj99XH1mgSWoBLaIIehoa0eLilo=;
 b=fEakcP7qpPvBvMIDb3tVRQkmtsuYDLsTuVYUqcyi0ijLCLvHkUQOPaMoxSi0I+qVmuY+
 Hsi66OQOtBatHPSi0Vez0SlxnhcUpEq7VreSvN3kv4v4l1EwvwH3oLaKS52nhqQuFzHo
 y19RiZzonb2vpDLlKCkv45x4bxBOEgXaY4L2FhFSQAvvb65tiUIxBE1sAxV5JOK/CHMN
 9WwScyEFUYCxsTsl7wMH1I2NOc1NWf18QE+w2sWgbkyRgVgoy/+Y+gtTJUNTSTewc9lr
 LxC5qBi7oGlrC+/8FkKbjqvlW8/k9FMixnAKwodc+Utv9Jq1AnX+Vq5DM+eKqu5fIob9 Fw== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38kh0h93br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 10:30:00 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14JATxuF027820;
        Wed, 19 May 2021 10:29:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38mechrmpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 10:29:59 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14JATwqt027765;
        Wed, 19 May 2021 10:29:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 38mechrmnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 10:29:58 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14JATuET025817;
        Wed, 19 May 2021 10:29:56 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 May 2021 10:29:55 +0000
Date:   Wed, 19 May 2021 13:29:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rajat Asthana <thisisrast7@gmail.com>
Cc:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: audio: Fix sparse warning.
Message-ID: <20210519102947.GU1955@kadam>
References: <20210519041624.824757-1-thisisrast7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519041624.824757-1-thisisrast7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: nlZpBf70bATXXpto94niN841qxTKtLt7
X-Proofpoint-ORIG-GUID: nlZpBf70bATXXpto94niN841qxTKtLt7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 09:46:24AM +0530, Rajat Asthana wrote:
> Enforce int type on SNDRV_CTL_ELEM_IFACE_MIXER to fix sparse warning:
> > warning: restricted snd_ctl_elem_iface_t degrades to integer
> 
> The iface field in the gb_audio_control struct is of type __u8, but the
> values stored in it are of type int. So on conversion they are degraded.
> Adding (__force int) will enforce them not to be degraded.
> 

The patch is fine, but the commit message is not very great.  This
patch doesn't "enforce" anything or affect the compiled code at all,
it just silences a Sparse warning.  Here is a better commit message.

  Sparse complains that:

    warning: restricted snd_ctl_elem_iface_t degrades to integer

  I have looked at this code, and the code is fine as-is.  Normally
  we would frown on using the __force directive to silence Sparse
  warnings but in this case it's fine.  Case statements can't be
  made into __bitwise types.  We also can't change the type of
  "ctl->iface" either because that is part of the user space API.

  So just add a (__force int) to make the warning go away.

regards,
dan carpenter

