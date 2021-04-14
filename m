Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2506C35EFAF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350057AbhDNIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:32:59 -0400
Received: from smtprelay0140.hostedemail.com ([216.40.44.140]:33196 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230373AbhDNIcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:32:53 -0400
Received: from omf05.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id EA65B4F9CB8B;
        Wed, 14 Apr 2021 08:32:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 00C88B2798;
        Wed, 14 Apr 2021 08:32:28 +0000 (UTC)
Message-ID: <d03e8b4ce25fe9e3b5e5597d83802eea83e7caa2.camel@perches.com>
Subject: Re: [PATCH 12/19] staging: rtl8723bs: remove unnecessary bracks on
 DBG_871X removal sites
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Wed, 14 Apr 2021 01:32:27 -0700
In-Reply-To: <20210413145245.GG6021@kadam>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
         <35f5edf0f39b717b3de3ad7861cbaa5f4ba60576.1617802415.git.fabioaiuto83@gmail.com>
         <20210413145245.GG6021@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00C88B2798
X-Spam-Status: No, score=0.10
X-Stat-Signature: xd3di5p38fnfpm3u6iu38r85oak485wx
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19OYrLfAlGdjVpbOKSYlKEKzknU7FRL29Q=
X-HE-Tag: 1618389148-702812
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-04-13 at 17:52 +0300, Dan Carpenter wrote:
> On Wed, Apr 07, 2021 at 03:49:36PM +0200, Fabio Aiuto wrote:
> > @@ -2586,11 +2583,9 @@ static int rtw_dbg_port(struct net_device *dev,
> >  
> > 
> >  								plist = get_next(plist);
> >  
> > 
> > -								if (extra_arg == psta->aid) {
> > -									for (j = 0; j < 16; j++) {
> > +								if (extra_arg == psta->aid)
> > +									for (j = 0; j < 16; j++)
> >  										preorder_ctrl = &psta->recvreorder_ctrl[j];
> > -									}
> > -								}
> 
> I think Greg already applied this so no stress (don't bother fixing),
> but you removed a bit too much on this one.  Multi-line indents normally
> get curly braces for readability.  In other words:
> 
> 				if (extra_arg == psta->aid) {
> 					for (j = 0; j < 16; j++)
> 						preorder_ctrl = &psta->recvreorder_ctrl[j];
> 				}
> 
> regards,
> dan carpenter
> 


