Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C89388F76
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353771AbhESNtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:49:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47234 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346639AbhESNtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:49:33 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JDlbAw014603;
        Wed, 19 May 2021 13:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=hKkNxCeeV5ubpGYC5anEExFajr09TOQeCeuI5eLF1o4=;
 b=A/Xbe/NVcYXOIrDxMrZWCozalfL5ZEIhjjmTyWWw8Y+k0TwGBetos9sf1WpKICsHij5K
 E/C4AYE1lheqGgZqsAEBcfzAG5RZ0PX2mMvRw1qcVe6KIqN7PPdDt+Y4Hqv7WwYuGnET
 Tz3ks1F47fco/bTLVbBp8b86BkO6iCA3DJ5hDD9hiEGBOs3cZv1fFpCeimWoLP1D19wX
 UC62I6Ach7H5S5rIZDQOcq5XSpjyj2F7CS3JG/+IuhSrs4JncuMLmb1n7e4EOsETpBiT
 0AoatHSLYrAEbSFwOsOagoeB+HmrjcGQp5EN9AVT/AuyZFkrhgDwUfjzcX0pR/Wg6oWD XA== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38n3dg009s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 13:48:07 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14JDm7ac158894;
        Wed, 19 May 2021 13:48:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38mecj8e3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 13:48:07 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14JDm6Vc158734;
        Wed, 19 May 2021 13:48:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 38mecj8e1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 13:48:06 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14JDm4KQ014423;
        Wed, 19 May 2021 13:48:04 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 May 2021 13:48:03 +0000
Date:   Wed, 19 May 2021 16:47:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rajat Asthana <thisisrast7@gmail.com>
Cc:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] greybus: audio: Fix sparse warning.
Message-ID: <20210519134754.GX1955@kadam>
References: <20210519102947.GU1955@kadam>
 <20210519134119.848055-1-thisisrast7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519134119.848055-1-thisisrast7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: vZy0g9eCQSCm3l-us7NV6EPpx2knZUYd
X-Proofpoint-GUID: vZy0g9eCQSCm3l-us7NV6EPpx2knZUYd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 07:11:19PM +0530, Rajat Asthana wrote:
> Sparse complains that:
>    warning: restricted send_ctl_elem_iface_t degrades to integer.
> 
> I have looked at this code, and the code is fine as-is. Normally we
> would frown on using the __force directive to silence Sparse warnings
> but in this case it's fine. Case statements can't be made into __bitwise
> types. We also can't change the type of "ctl->iface" either because that
> is part of the user space API.
> 
> So just add a (__force int) to make the warning go away.
> 
> Signed-off-by: Rajat Asthana <thisisrast7@gmail.com>
> ---
> Changes in v2:
>     - Update the commit message.

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

