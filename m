Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62073E4C3A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 20:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbhHIShU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 14:37:20 -0400
Received: from lan.nucleusys.com ([92.247.61.126]:38940 "EHLO
        zzt.nucleusys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235268AbhHIShR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=nucleusys.com; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kJtEPbz3HBfjcS7eIEk4ujeRQjWezW+oEUGElqZZsfI=; b=fths+KCxw/Vl/Dt0HU3NNxXI0H
        loGziGRZA31hkBGAfuNL/Lal721gpcrk2lu8VNv9QGn7o5x++6HjLpqWdIbsR0YmJabCaltBEvxKs
        G9FmDSXPps1QCEBnJ7f1CtpWIPa0GeXHzFTMJkSgUVeLOq/BleIFeyb07tCEtrwu5S4I=;
Received: from 78-83-68-78.spectrumnet.bg ([78.83.68.78] helo=carbon)
        by zzt.nucleusys.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <petkan@nucleusys.com>)
        id 1mDA8d-0002Mp-R5; Mon, 09 Aug 2021 21:36:43 +0300
Date:   Mon, 9 Aug 2021 21:36:39 +0300
From:   Petko Manolov <petkan@nucleusys.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/net/usb/pegasus.c:461:2: warning: Value stored to 'ret'
 is never read [clang-analyzer-deadcode.DeadStores]
Message-ID: <YRF1t5kx6hTrv5LC@carbon>
Mail-Followup-To: Pavel Skripkin <paskripkin@gmail.com>,
        kernel test robot <rong.a.chen@intel.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202108080902.ZhmxmJZr-lkp@intel.com>
 <28df02cc-8b34-3d4e-2ed6-30af0ff44a42@intel.com>
 <94550f41-1204-8996-ef32-c25429481ceb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94550f41-1204-8996-ef32-c25429481ceb@gmail.com>
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: Spam detection software, running on the system "zzt.nucleusys.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  On 21-08-09 14:06:11, Pavel Skripkin wrote: > On 8/9/21 1:37
    PM, kernel test robot wrote: > > > > tree: > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    master > > head: 85a90500 [...] 
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  0.0 TVD_RCVD_IP            Message was received from an IP address
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-09 14:06:11, Pavel Skripkin wrote:
> On 8/9/21 1:37 PM, kernel test robot wrote:
> > 
> > tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   85a90500f9a1717c4e142ce92e6c1cb1a339ec78
> > commit: 8a160e2e9aeb8318159b48701ad8a6e22274372d net: usb: pegasus:
> > Check the return value of get_geristers() and friends;
> > date:   4 days ago
> > :::::: branch date: 8 hours ago
> > :::::: commit date: 4 days ago
> > config: x86_64-randconfig-c001-20210808 (attached as .config)
> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project
> > 41a6b50c25961addc04438b567ee1f4ef9e40f98)
> > reproduce (this is a W=1 build):
> >           wget
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > -O ~/bin/make.cross
> >           chmod +x ~/bin/make.cross
> >           # install x86_64 cross compiling tool for clang build
> >           # apt-get install binutils-x86-64-linux-gnu
> >           #
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a160e2e9aeb8318159b48701ad8a6e22274372d
> >           git remote add linus
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >           git fetch --no-tags linus master
> >           git checkout 8a160e2e9aeb8318159b48701ad8a6e22274372d
> >           # save the attached .config to linux build tree
> >           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> > ARCH=x86_64 clang-analyzer
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> Hi, @Petko!
> 
> For you not to scan all these warnings:
> 
> > > > drivers/net/usb/pegasus.c:461:2: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
> >              ret = set_registers(pegasus, EthCtrl0, 3, data);
> >              ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      drivers/net/usb/pegasus.c:461:2: note: Value stored to 'ret' is
> > never read
> >              ret = set_registers(pegasus, EthCtrl0, 3, data);
> >              ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This is the real bug, I think. Can be fixed like this:
> 
> diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
> index 22353bab76c8..f2b8891c7b36 100644
> --- a/drivers/net/usb/pegasus.c
> +++ b/drivers/net/usb/pegasus.c
> @@ -459,6 +459,8 @@ static int enable_net_traffic(struct net_device *dev,
> struct usb_device *usb)
> 
>  	memcpy(pegasus->eth_regs, data, sizeof(data));
>  	ret = set_registers(pegasus, EthCtrl0, 3, data);
> +	if (ret < 0)
> +		goto fail;
> 
>  	if (usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS ||
>  	    usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS2 ||
> 
> 
> It was caused by our last refactoring: enable_net_traffic() now returns 0 on
> success and this ret is never checked.

I'd rather remove the 'ret = ' part and leave set_registers() alone.  If this
particular write operation fail, it doesn't mean the adapter won't work at all.
Perhaps it won't be the most optimal mode, but it will work.  There are some
legal checks after set_registers() that also make sense to pass.  So the patch i
suggest looks like:


diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index 652e9fcf0b77..49cfc720d78f 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -433,7 +433,7 @@ static int enable_net_traffic(struct net_device *dev, struct usb_device *usb)
        data[2] = loopback ? 0x09 : 0x01;

        memcpy(pegasus->eth_regs, data, sizeof(data));
-       ret = set_registers(pegasus, EthCtrl0, 3, data);
+       set_registers(pegasus, EthCtrl0, 3, data);

        if (usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS ||
            usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS2 ||


cheers,
Petko
