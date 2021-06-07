Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FB839D2FE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 04:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhFGCgy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 6 Jun 2021 22:36:54 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37594 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFGCgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 22:36:54 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1572YcfM6013385, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1572YcfM6013385
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Jun 2021 10:34:38 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 7 Jun 2021 10:34:37 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 7 Jun 2021 10:34:37 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::3132:fefa:293c:f022]) by
 RTEXMBS01.realtek.com.tw ([fe80::3132:fefa:293c:f022%13]) with mapi id
 15.01.2106.013; Mon, 7 Jun 2021 10:34:36 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "rui_feng@realsil.com.cn" <rui_feng@realsil.com.cn>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "vaibhavgupta40@gmail.com" <vaibhavgupta40@gmail.com>,
        "yang.lee@linux.alibaba.com" <yang.lee@linux.alibaba.com>,
        "keitasuzuki.park@sslab.ics.keio.ac.jp" 
        <keitasuzuki.park@sslab.ics.keio.ac.jp>,
        "chris.chiu@canonical.com" <chris.chiu@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] misc: rtsx: separate aspm mode into MODE_REG and MODE_CFG
Thread-Topic: [PATCH] misc: rtsx: separate aspm mode into MODE_REG and
 MODE_CFG
Thread-Index: AQHXWU/UGLRxSayzj0i+9UIgK1MEBasDaJ6AgARtaUA=
Date:   Mon, 7 Jun 2021 02:34:36 +0000
Message-ID: <3b0e8f86e1d04552beece07b61709734@realtek.com>
References: <20210604144211.6470-1-ricky_wu@realtek.com>
 <YLo9O/gGOuFIsVH0@kroah.com>
In-Reply-To: <YLo9O/gGOuFIsVH0@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.137.180.121]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/6/6_=3F=3F_11:20:00?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/07/2021 02:19:25
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164137 [Jun 06 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: ricky_wu@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/07/2021 02:22:00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Friday, June 4, 2021 10:48 PM
> To: Ricky WU
> Cc: arnd@arndb.de; bhelgaas@google.com; rui_feng@realsil.com.cn;
> ulf.hansson@linaro.org; vaibhavgupta40@gmail.com;
> yang.lee@linux.alibaba.com; keitasuzuki.park@sslab.ics.keio.ac.jp;
> chris.chiu@canonical.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] misc: rtsx: separate aspm mode into MODE_REG and
> MODE_CFG
> 
> On Fri, Jun 04, 2021 at 10:42:11PM +0800, ricky_wu@realtek.com wrote:
> > From: Ricky Wu <ricky_wu@realtek.com>
> >
> > Divide Realtek Card Reader Group into two different modes
> > ASPM_MODE_CFG: 8411 5209 5227 5229 5249 5250 Change back to use
> > original way to control aspm
> 
> What is "aspm"?
> 
Active State Power Management (ASPM)
rtsx_comm_set_aspm: ASPM control function for our driver
to make sure not enter power saving in process of init and card_detcct 

> > +#define ASPM_MODE_CFG		0x01
> > +#define ASPM_MODE_REG		0x02
> > +	u8				aspm_mode;
> 
> Why not use an enum?
> 

It is ok, we can have a V2 to use enum

> thanks,
> 
> greg k-h
> ------Please consider the environment before printing this e-mail.
