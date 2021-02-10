Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443DB3161D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhBJJNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:13:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56122 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhBJJFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:05:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A8xHVY193961;
        Wed, 10 Feb 2021 09:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Pvku0g5qRFieLOM0rbLElmAI0mtXmeHjEhMXWDBSy08=;
 b=wb9CSbrNM3YvqhO5Br7RFK/DhRUH98nV0Ork6EznWCCJuRcTl1z9IqdU0eHDCgpyCRip
 jXc764gVdWhFeWa2quYxbEru+Q+NMuiR13OVDMOjxSYRMDxvJmXKvLBxiiKqsdCHcUkT
 Zbp06iPITSd40peQNxbMIVQaoI6lMqEfE2bxUha6CS8JN0P3VOyeOTRikGYVycHTHbJu
 hARorIk3Hg+R4p1Cxz6o6w4gba+HMeLlpVeu/RgXDwmJ1WnZn8kkP3Blm5d/b9WZ/o++
 0Q06u+sjWAGNjxfQVvD0rg+5JYZBgPBbanOjiisxn2dCJUMy0k1ZgdZFXk8By1bje2P/ xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36m4ups1ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 09:04:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A94fem172112;
        Wed, 10 Feb 2021 09:04:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 36j4vshn3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 09:04:50 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11A94npg025505;
        Wed, 10 Feb 2021 09:04:49 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 01:04:48 -0800
Date:   Wed, 10 Feb 2021 12:04:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: gdm724x: Fix DMA from stack
Message-ID: <20210210090442.GV2696@kadam>
References: <20210210080134.1978-1-ameynarkhede03@gmail.com>
 <YCOUIFVuvJuPP3lX@kroah.com>
 <20210210085811.7dunnfly6cqw67m3@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210085811.7dunnfly6cqw67m3@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100093
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 02:28:11PM +0530, Amey Narkhede wrote:
> On 21/02/10 09:06AM, Greg KH wrote:
> > On Wed, Feb 10, 2021 at 01:31:34PM +0530, Amey Narkhede wrote:
> > > Stack allocated buffers cannot be used for DMA
> > > on all architectures so allocate hci_packet buffer
> > > using kzalloc().
> > >
> > > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > > ---
> > > Changes in v2:
> > > 	- Fixed build warning
> > > 	- Fixed memory leak using kfree
> > >
> > >  drivers/staging/gdm724x/gdm_usb.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
> > > index dc4da66c3..c4a9b90c5 100644
> > > --- a/drivers/staging/gdm724x/gdm_usb.c
> > > +++ b/drivers/staging/gdm724x/gdm_usb.c
> > > @@ -56,11 +56,15 @@ static int gdm_usb_recv(void *priv_dev,
> > >
> > >  static int request_mac_address(struct lte_udev *udev)
> > >  {
> > > -	u8 buf[16] = {0,};
> > > -	struct hci_packet *hci = (struct hci_packet *)buf;
> > > +	u8 *buf;
> > > +	struct hci_packet *hci;
> > >  	struct usb_device *usbdev = udev->usbdev;
> > >  	int actual;
> > >  	int ret = -1;
> > > +	buf = kzalloc(16, GFP_KERNEL);
> >
> > checkpatch did not complain about this?
> No. checkpatch shows no errors and warnings.
> >
> > And why do you need 'buf' anymore now?  Why not just allocate hci and
> > pass that to the request instead?  Saves you an extra cast and an extra
> > pointer.
> >
> > thanks,
> >
> > greg k-h
> Thanks. I'll send v3. I assume now we don't need kzalloc anymore as we initialize
> the hci_packet so kmalloc(sizeof(struct hci_packet),..) will do.

We only initialize the first five bytes, but it also seems as if we only
use the first five bytes which raises the question of why we are
allocating 16 bytes.

regards,
dan carpenter

