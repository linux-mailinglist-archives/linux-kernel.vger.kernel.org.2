Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4310539B4D0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFDI2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:28:20 -0400
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:36416 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229900AbhFDI2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:28:19 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 285BFDB5C;
        Fri,  4 Jun 2021 08:26:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id AD175D1516;
        Fri,  4 Jun 2021 08:26:31 +0000 (UTC)
Message-ID: <19651be0dc8706da34658d25195ff122f41ee7c0.camel@perches.com>
Subject: Re: [greybus-dev] [PATCH] staging: greybus: fixed the coding style,
 labels should not be indented.
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Alex Elder' <elder@linaro.org>,
        'Manikishan Ghantasala' <manikishanghantasala@gmail.com>,
        Alex Elder <elder@ieee.org>
Cc:     Alex Elder <elder@kernel.org>,
        "greybus-dev@lists.linaro.org" <greybus-dev@lists.linaro.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        Johan Hovold <johan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 04 Jun 2021 01:26:30 -0700
In-Reply-To: <c29b5c97f97b48c894917647915bf510@AcuMS.aculab.com>
References: <20210602133659.46158-1-manikishanghantasala@gmail.com>
         <9a3878fd-3b59-76f5-ddc7-625c66f9fee8@ieee.org>
         <CAKzJ-FNW8EPX2oQd1qr5NagnvjtWwvSeuAh8DNLetj11+BJ6RA@mail.gmail.com>
         <792dd57c0ef8454497e5ae4c4534dea2@AcuMS.aculab.com>
         <e1c36fb4-ab72-0cce-f6fe-3f04125dae28@linaro.org>
         <e23879ae78404be2b707b550b3029e43@AcuMS.aculab.com>
         <10ad30e2-c906-b210-bf0e-5e20b6de1993@linaro.org>
         <c29b5c97f97b48c894917647915bf510@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: AD175D1516
X-Spam-Status: No, score=-2.77
X-Stat-Signature: wjdyupwsx14pw579haxy5xkypixm9osy
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19fS19ixJkOAeDle8y0KO0ufAQmRER3gi0=
X-HE-Tag: 1622795191-465470
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-06-04 at 08:13 +0000, David Laight wrote:
> From: Alex Elder
> > Sent: 03 June 2021 22:55
> ...
> > Not necessarily, sizeof(bool) is implementation defined.
> > And I thought you didn't think the size of the structure
> > was very important...
> 
> It is 'implementation defined' but will be 32 bits on everything
> except an old 32bit ARM ABI.

Really? (x86-64)

$ gcc -x c -
#include <stdio.h>
#include <stdlib.h>

struct foo {
	_Bool b;
};

int main(int argc, char **argv)
{
	printf("sizeof _Bool: %zu\n", sizeof(_Bool));
	printf("sizeof struct foo: %zu\n", sizeof(struct foo));
	return 0;
}
$ ./a.out
sizeof _Bool: 1
sizeof struct foo: 1


