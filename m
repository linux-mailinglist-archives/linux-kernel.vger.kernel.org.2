Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3BD39DC00
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhFGMN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:13:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1880 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbhFGMN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:13:28 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 157CB8Ik004929;
        Mon, 7 Jun 2021 12:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=pZLJ3N8oQ+Cwxb2RB0pk4+Uwb/hm7c91pSe9ik8C1bA=;
 b=apkfOjyhVp3Iq/O95t8eO4/YLTEwjnlqXatAFshcPbhxgKevKybb3wH9k9FYFJ8m+TN0
 HIYjG8UBquyZQU6q9coG7XMEqw2BzWnTBMia3pYxYTCbTSdkWzGsZTAJ8G/oCqoanBCh
 WKtDikiYpoMIXxPdBk/W2HW1KfNVu4Aw+lFC0l+z51bqK32GrYitgVjLhVPzVhQuiRjK
 CKCpsW9DfD8PSC8lGtN2EqE9pF1mq4FhbPrlCPvWxpB5a7Yrs0Qh7tW4mgFBHZV0FJyk
 AD10Znt+FCA0y6tYRmx74Ru3Zs2BffxFdLS/kEnrT4ndgRj1BE2ouepa7Xw2HbN8EUM0 qA== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3916ehr7jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 12:11:16 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 157CBFp6145451;
        Mon, 7 Jun 2021 12:11:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38yxctt86b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 12:11:15 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 157CAO6I144209;
        Mon, 7 Jun 2021 12:11:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 38yxctt85f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 12:11:15 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 157CBDVD021659;
        Mon, 7 Jun 2021 12:11:13 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jun 2021 05:11:13 -0700
Date:   Mon, 7 Jun 2021 15:11:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Use list iterators and helpers
Message-ID: <20210607121106.GU1955@kadam>
References: <20210428173301.149619-1-linux@roeck-us.net>
 <20210604172632.GA1526@agape.jhs>
 <20210605005422.GB255680@roeck-us.net>
 <20210607111704.GT1955@kadam>
 <20210607112648.GA314533@roeck-us.net>
 <20210607113624.GA1410@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607113624.GA1410@agape.jhs>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: iXKgOpSC4WKwiBnmE6EadXG3ZdbqzY6v
X-Proofpoint-ORIG-GUID: iXKgOpSC4WKwiBnmE6EadXG3ZdbqzY6v
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 01:36:24PM +0200, Fabio Aiuto wrote:
> On Mon, Jun 07, 2021 at 04:26:48AM -0700, Guenter Roeck wrote:
> > On Mon, Jun 07, 2021 at 02:17:04PM +0300, Dan Carpenter wrote:
> > > On Fri, Jun 04, 2021 at 05:54:22PM -0700, Guenter Roeck wrote:
> > > > On Fri, Jun 04, 2021 at 07:26:33PM +0200, Fabio Aiuto wrote:
> > > > > Hello Guenter,
> > > > > 
> > > > > On Wed, Apr 28, 2021 at 10:33:01AM -0700, Guenter Roeck wrote:
> > > > > > The rtl8723bs driver manually re-implements list helper functions
> > > > > > and macros in various ways. Replace with existing list helpers.
> > > > > 
> > > > > I'm testing rtl8723bs on a baytrail tablet (Lenovo Ideapad MIIX 300-10IBY)
> > > > > and applying the tag staging-5.13-rc4, loading r8723bs makes the whole
> > > > > system freezing while trying to connect to local AP.
> > > > > 
> > > > > Only a power off is allowed.
> > > > > 
> > > > > I found that commit b3cd518c5abd42fbc747ef55a5fdc40bf7bf01c0
> > > > > (staging: rtl8723bs: Use list iterators and helpers)
> > > > > introduced the bug.
> > > > > 
> > > > > I'm trying to find out what's wrong with this patch, have you any suggestions?
> > > > 
> > > > Some of the iterators needed the _safe variant which I didn't take into account.
> > > > I thought that was fixed, but maybe some locations were missed.
> > > 
> > > Ah...  Crud.  As near as I can tell Martin fixed a lot of these in the driver
> > > he is working on, rtl8188eu.  But they still aren't fixed in rtl8723bs.  I looked
> > > at the functions and the following loops need to changed to list_for_each_safe().
> > > (Doing a search for list_del_init() helped during review).
> > > 
> > 
> > Hans wants the patch introducing the problem reverted, so I won't bother
> > sending a fix. Sorry for the trouble. Learned a lesson (I hope).
> > 
> > Guenter
> > 
> > > expire_timeout_chk() (both loops)
> > > rtw_acl_remove_sta()
> > > rtw_sta_flush()
> > > stop_ap_mode()
> > > 
> > > rtw_free_network_queue()
> > > chk_bmc_sleepq_hdl()
> > > rtw_free_all_stainfo()
> > > rtw_free_xmitframe_queue()
> > > dequeue_xmitframes_to_sleeping_queue()
> > > wakeup_sta_to_xmit()  (both loops)
> > > xmit_delivery_enabled_frames()
> > > 
> > > xmit_xmitframes()
> > > cfg80211_rtw_del_station()
> > > 
> > > regards,
> > > dan carpenter
> > > 
> > > 
> 
> thanks to Guenter suggestion I made the fix needed, if there's no particular
> hurry to revert the change I'm submitting it today or tomorrow at most.
> Will cross check with Dan's hint either.

Thanks Fabio.  I feel like we can fix this.  No need to revert.  I'm
going through the changes to rtl8188eu and I've spotted a couple
functions which Martin missed so I'm going to send those as well.

regards,
dan carpenter

