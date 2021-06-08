Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D8439FDCA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhFHRgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:36:17 -0400
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:35934 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232628AbhFHRgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:36:16 -0400
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A84DD1802768D;
        Tue,  8 Jun 2021 17:34:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id D63722EBFA9;
        Tue,  8 Jun 2021 17:34:21 +0000 (UTC)
Message-ID: <eb8d5431301686000746524882c06121a2d21189.camel@perches.com>
Subject: Re: [PATCH -next 2/2] staging: r8188eu: use eth_broadcast_addr() to
 assign broadcast address
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Liu Shixin <liushixin2@huawei.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Jun 2021 10:34:20 -0700
In-Reply-To: <YL+ib+tJwKckXagY@kroah.com>
References: <20210608141620.525521-1-liushixin2@huawei.com>
         <YL96vz4okNehxCBG@kroah.com>
         <b77a3e7b0923344e8c5b9b17f4788d28f3ccfb4f.camel@perches.com>
         <YL+ib+tJwKckXagY@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.90
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: D63722EBFA9
X-Stat-Signature: rw44uyzpkapeqtxq56hmgrhf3nuoe1uq
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18c9oRogXoskGGUuR46UUayQp3MM5TsUb0=
X-HE-Tag: 1623173661-547712
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-06-08 at 19:01 +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 08, 2021 at 09:45:49AM -0700, Joe Perches wrote:
> > On Tue, 2021-06-08 at 16:12 +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Jun 08, 2021 at 10:16:20PM +0800, Liu Shixin wrote:
> > > > Use eth_broadcast_addr() to assign broadcast address.
> > > 
> > > That says what you do, but not _why_ you are doing this?
> > > 
> > > Why make this change?  What benifit does it provide?
> > 
> > The commit message is clear and concise as using available kernel
> > mechanisms is better than homegrown or duplicative ones.
> > 
> > Are you asking merely becuse Liu Shixin hasn't had many staging
> > commits?
> 
> I'm asking because this changelog text does not explain why this is
> needed at all and needs to be changed to do so.

IYO.

IMO it's obvious and fine as is and you are asking for overly
fine-grained analyses in commit messages.

The subject is clear though the commit message is merely duplicative.

It _could_ show the reduction in object size for some versions of gcc.

$ size drivers/staging/rtl8188eu/core/rtw_mlme_ext.o*
   text	   data	    bss	    dec	    hex	filename
  53259	    372	   2430	  56061	   dafd	drivers/staging/rtl8188eu/core/rtw_mlme_ext.o.gcc6.new
  53355	    372	   2430	  56157	   db5d	drivers/staging/rtl8188eu/core/rtw_mlme_ext.o.gcc6.old
  54673	    372	   2430	  57475	   e083	drivers/staging/rtl8188eu/core/rtw_mlme_ext.o.gcc10.new
  54673	    372	   2430	  57475	   e083	drivers/staging/rtl8188eu/core/rtw_mlme_ext.o.gcc10.old

It _could_ describe how the kernel mechanisms depend on a minimum
alignment of __aligned(2) in the tested address and also show that
the address is properly minimum aligned.

struct ieee80211_hdr {
	__le16 frame_control;
	__le16 duration_id;
	u8 addr1[ETH_ALEN];
	u8 addr2[ETH_ALEN];
	u8 addr3[ETH_ALEN];
	__le16 seq_ctrl;
	u8 addr4[ETH_ALEN];
} __packed __aligned(2);
[...]
	struct ieee80211_hdr *pwlanhdr;
[...]
-	ether_addr_copy(pwlanhdr->addr1, bc_addr);
+	eth_broadcast_addr(pwlanhdr->addr1);

It _could_ show that the commit has some effect on runtime.
It _could_ show that it passes some (unavailable) regression test.

IMO: None of those are really necessary here.


