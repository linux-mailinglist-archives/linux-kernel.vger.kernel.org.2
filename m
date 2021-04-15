Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EBF361201
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbhDOSTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:19:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51082 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbhDOSTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:19:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FIFU52066559;
        Thu, 15 Apr 2021 18:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=sSRqnc8CP7d/ScOvRgpRssO7lfHgLBctuEO2QPJ6yFI=;
 b=Sb8k4Iqf+sOpMFNQuCexhjG0vdwHbcNsaNewnh02VoSu7/K6TAbAw1xeKEtXUQH9KbGX
 M9TZQXNg6rsgQ8HMt59D2tV3oHQ6Nyh9j9dVgcXRitkYZI2aN565r4VZ2U+iux2CZies
 6RXcChQyQSekJ08w5zh3wszkkrMzk1ThNkIUSmhS+b7ewg+WpkIESFiTmMjQ6Uonbl79
 qAwJFxJhgLdFJWT/QMBQFaVEgZLGARsynO8H/McBj8c0MrAtMa3nnxZ+Y0QqqLzdpSq7
 Ux8xswQK8wo8LI6tkbt4F0L9r1liBOqiEfLu5pVsM4RuEDxzCjfl824fSsYrJAwmN0Qw Ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37u3ymptm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 18:19:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FIFoPr068218;
        Thu, 15 Apr 2021 18:19:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 37unx3app9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 18:19:07 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13FIJ5dm023900;
        Thu, 15 Apr 2021 18:19:05 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Apr 2021 11:19:04 -0700
Date:   Thu, 15 Apr 2021 21:18:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: uniphier: Fix potential infinite loop
Message-ID: <20210415181850.GD6021@kadam>
References: <20210407152457.497346-1-colin.king@canonical.com>
 <CAK7LNAT+JTg5QYYbYqCm+m11X7CF_ZWyYRA4eAtqeTEuHRqoyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAT+JTg5QYYbYqCm+m11X7CF_ZWyYRA4eAtqeTEuHRqoyw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150114
X-Proofpoint-GUID: 6Byqh3omvf4T8b_6-ZEm8CNEuvS2tfKT
X-Proofpoint-ORIG-GUID: 6Byqh3omvf4T8b_6-ZEm8CNEuvS2tfKT
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104150114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 03:46:47PM +0900, Masahiro Yamada wrote:
> On Thu, Apr 8, 2021 at 12:25 AM Colin King <colin.king@canonical.com> wrote:
> >
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > The for-loop iterates with a u8 loop counter i and compares this
> > with the loop upper limit of num_parents that is an int type.
> > There is a potential infinite loop if num_parents is larger than
> > the u8 loop counter. Fix this by making the loop counter the same
> > type as num_parents.
> >
> > Addresses-Coverity: ("Infinite loop")
> > Fixes: 734d82f4a678 ("clk: uniphier: add core support code for UniPhier clock driver")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/clk/uniphier/clk-uniphier-mux.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/uniphier/clk-uniphier-mux.c b/drivers/clk/uniphier/clk-uniphier-mux.c
> > index 462c84321b2d..ce219e0d2a85 100644
> > --- a/drivers/clk/uniphier/clk-uniphier-mux.c
> > +++ b/drivers/clk/uniphier/clk-uniphier-mux.c
> > @@ -34,7 +34,7 @@ static u8 uniphier_clk_mux_get_parent(struct clk_hw *hw)
> >         int num_parents = clk_hw_get_num_parents(hw);
> >         int ret;
> >         unsigned int val;
> > -       u8 i;
> > +       int i;
> >
> >         ret = regmap_read(mux->regmap, mux->reg, &val);
> >         if (ret)
> > --
> > 2.30.2
> >
> 
> clk_hw_get_num_parents() returns 'unsigned int', so
> I think 'num_parents' should also have been 'unsigned int'.
> 
> Maybe, the loop counter 'i' also should be 'unsigned int' then?

The clk_hw_get_num_parents() function returns 0-255 so the original code
works fine.

It should basically always be "int i;"  That's the safest assumption.
There are other case where it has to be size_t but in those cases I
think people should call the list iterator something else instead of "i"
like "size_t pg_idx;".

Making everthing u32 causes more bugs than it prevents.  Signedness bugs
with comparing to zero, type promotion bugs, or subtraction bugs where
subtracting wraps to a high value.  It's rare to loop more than INT_MAX
times in the kernel.  When we do need to count about 2 million then
we're probably not going to stop counting at 4 million, we're going to
go to 10 million or higher so size_t is more appropriate than u32.

Btw, if you have a loop that does:

	for (i = 0; i < UINT_MAX; i++) {

that loop works exactly the same if "i" is an int or if it's a u32
because of type promotion.  So you have to look really hard to find a
place where changing a loop iterator from int to u32 fixes bug in real
life.

regards,
dan carpenter
