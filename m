Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BD13ED050
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 10:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhHPIct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 04:32:49 -0400
Received: from mx21.baidu.com ([220.181.3.85]:53782 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234456AbhHPIcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:32:48 -0400
Received: from BC-Mail-Ex15.internal.baidu.com (unknown [172.31.51.55])
        by Forcepoint Email with ESMTPS id 3A93C1EA7E9699F659F6;
        Mon, 16 Aug 2021 16:32:14 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex15.internal.baidu.com (172.31.51.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Mon, 16 Aug 2021 16:32:14 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 16
 Aug 2021 16:32:13 +0800
Date:   Mon, 16 Aug 2021 16:32:13 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <dan.carpenter@oracle.com>, <yangyingliang@huawei.com>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: r8188eu: Remove the dependency on ipx.h
Message-ID: <20210816083213.GA1784@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20210816075406.938-1-caihuoqing@baidu.com>
 <YRodb5XKDC7NF/pQ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YRodb5XKDC7NF/pQ@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex11.internal.baidu.com (172.31.51.51) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Aug 21 10:10:23, Greg KH wrote:
> On Mon, Aug 16, 2021 at 03:54:06PM +0800, Cai Huoqing wrote:
> > commit <47595e32869f> ("<MAINTAINERS: Mark some staging directories>")
> > indicated the ipx network layer as obsolete in Jan 2018,
> > updated in the MAINTAINERS file
> > 
> > now, after being exposed for 3 years to refactoring,
> > so to remove the dependency on ipx.h
> > 
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_br_ext.c | 24 ++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> See:
> 	https://lore.kernel.org/r/20210816073450.668993-2-gregkh@linuxfoundation.org
cool
> 
> for a different approach to this.
> 
> thanks,
> 
> greg k-h
> 
