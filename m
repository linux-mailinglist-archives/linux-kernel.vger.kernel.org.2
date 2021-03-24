Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E82347088
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 05:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbhCXEn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 00:43:27 -0400
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:50742 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232680AbhCXEnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 00:43:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B75B3181D303A;
        Wed, 24 Mar 2021 04:43:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:857:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3871:3872:3874:4321:5007:7514:7652:8879:9010:10004:10400:10848:11026:11232:11658:11783:11914:12048:12296:12297:12438:12555:12740:12895:13069:13161:13229:13311:13357:13439:13894:13972:14181:14659:14721:21080:21451:21611:21627:21773:30029:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wax59_1b1093527778
X-Filterd-Recvd-Size: 2080
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Mar 2021 04:43:15 +0000 (UTC)
Message-ID: <c0eb61bee95906c1aef3631dcd95388957a229c7.camel@perches.com>
Subject: Re: [PATCH] video: mmp: Few typo fixes
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 23 Mar 2021 21:43:14 -0700
In-Reply-To: <30241dd5-dfd5-ec67-569b-1552bef58e95@infradead.org>
References: <20210322130210.3641181-1-unixbhaskar@gmail.com>
         <30241dd5-dfd5-ec67-569b-1552bef58e95@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-03-22 at 12:36 -0700, Randy Dunlap wrote:
> On 3/22/21 6:02 AM, Bhaskar Chowdhury wrote:
> > 
> > s/configed/configured/
> > s/registed/registered/
> > s/defintions/definitions/
> > 
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
[]
> > diff --git a/include/video/mmp_disp.h b/include/video/mmp_disp.h
> > index 77252cb46361..ea8b4331b7a1 100644
> > --- a/include/video/mmp_disp.h
> > +++ b/include/video/mmp_disp.h
> > @@ -172,7 +172,7 @@ struct mmp_panel {
> >  	/* use node to register to list */
> >  	struct list_head node;
> >  	const char *name;
> > -	/* path name used to connect to proper path configed */
> > +	/* path name used to connect to proper path configured */

The spelling is now correct, but the word order doesn't make much sense.

> > @@ -291,7 +291,7 @@ static inline int mmp_overlay_set_addr(struct mmp_overlay *overlay,
> >   * it defined a common interface that plat driver need to implement
> >   */
> >  struct mmp_path_info {
> > -	/* driver data, set when registed*/
> > +	/* driver data, set when registered*/

should have a space before */


