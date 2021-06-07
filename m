Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19F839DAF1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhFGLT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:19:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46510 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230145AbhFGLT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:19:26 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 157B6jRI022124;
        Mon, 7 Jun 2021 11:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=xyylL6muB6UNgPnpF/UEaCAiePjQM8s+zRlFb5Gw51E=;
 b=y1d0uDSbXSDD7kg06TfudcjNtUvRlGyQsauyURKUT8y1xMWdi+bJbggn8lzE0TFz3w+o
 KORoHSWVNxB3jbweJnS5Skc3N4zKVJNVUfB7Ya224W9V78zv///tcbdR7JAvRdAYpcqW
 ioWfozvXxxByvAKhPR/f1ojLP4Q4hbJCRL9R6sRJjNZMEXvH8RLf0CbUqwur9FMjoUpO
 ynIo9nVrAAqYWG1fPkcZDJy4PsBaMbEkKuxLWlC56FJuiq1YvipnCCuSjh8n5+AkQgUt
 LLcbq4CvZTmC/l65AO3qyp8GLPoSC7WWgnp/b3/chQM4ejjAwNJoEo81LVEahLJ0MHtU EA== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3916m086vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 11:17:16 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 157BHE6d065706;
        Mon, 7 Jun 2021 11:17:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 390k1pye6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 11:17:14 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 157BHEmG065688;
        Mon, 7 Jun 2021 11:17:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 390k1pye6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 11:17:14 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 157BHCIV014403;
        Mon, 7 Jun 2021 11:17:13 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jun 2021 04:17:12 -0700
Date:   Mon, 7 Jun 2021 14:17:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Fabio Aiuto <fabioaiuto83@gmail.com>, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Use list iterators and helpers
Message-ID: <20210607111704.GT1955@kadam>
References: <20210428173301.149619-1-linux@roeck-us.net>
 <20210604172632.GA1526@agape.jhs>
 <20210605005422.GB255680@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605005422.GB255680@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: NDZiDbg-uokbq8DpkyFIB_Tc4poOtMn5
X-Proofpoint-GUID: NDZiDbg-uokbq8DpkyFIB_Tc4poOtMn5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 05:54:22PM -0700, Guenter Roeck wrote:
> On Fri, Jun 04, 2021 at 07:26:33PM +0200, Fabio Aiuto wrote:
> > Hello Guenter,
> > 
> > On Wed, Apr 28, 2021 at 10:33:01AM -0700, Guenter Roeck wrote:
> > > The rtl8723bs driver manually re-implements list helper functions
> > > and macros in various ways. Replace with existing list helpers.
> > 
> > I'm testing rtl8723bs on a baytrail tablet (Lenovo Ideapad MIIX 300-10IBY)
> > and applying the tag staging-5.13-rc4, loading r8723bs makes the whole
> > system freezing while trying to connect to local AP.
> > 
> > Only a power off is allowed.
> > 
> > I found that commit b3cd518c5abd42fbc747ef55a5fdc40bf7bf01c0
> > (staging: rtl8723bs: Use list iterators and helpers)
> > introduced the bug.
> > 
> > I'm trying to find out what's wrong with this patch, have you any suggestions?
> 
> Some of the iterators needed the _safe variant which I didn't take into account.
> I thought that was fixed, but maybe some locations were missed.

Ah...  Crud.  As near as I can tell Martin fixed a lot of these in the driver
he is working on, rtl8188eu.  But they still aren't fixed in rtl8723bs.  I looked
at the functions and the following loops need to changed to list_for_each_safe().
(Doing a search for list_del_init() helped during review).

expire_timeout_chk() (both loops)
rtw_acl_remove_sta()
rtw_sta_flush()
stop_ap_mode()

rtw_free_network_queue()
chk_bmc_sleepq_hdl()
rtw_free_all_stainfo()
rtw_free_xmitframe_queue()
dequeue_xmitframes_to_sleeping_queue()
wakeup_sta_to_xmit()  (both loops)
xmit_delivery_enabled_frames()

xmit_xmitframes()
cfg80211_rtw_del_station()

regards,
dan carpenter


