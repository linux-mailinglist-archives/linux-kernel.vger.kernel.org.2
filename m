Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CAD323789
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 07:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhBXGuD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Feb 2021 01:50:03 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:53899 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbhBXGtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 01:49:41 -0500
Received: from xps13 (lfbn-tou-1-972-113.w86-210.abo.wanadoo.fr [86.210.203.113])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3E15A240005;
        Wed, 24 Feb 2021 06:48:51 +0000 (UTC)
Date:   Wed, 24 Feb 2021 07:48:50 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     mdalam@codeaurora.org
Cc:     mani@kernel.org, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        sricharan@codeaurora.org, mdalam=codeaurora.org@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: update last code word register
Message-ID: <20210224074850.0c74154d@xps13>
In-Reply-To: <38da9d1d4a96f1b42ba0b194da265e6b@codeaurora.org>
References: <1614024267-12529-1-git-send-email-mdalam@codeaurora.org>
        <20210223173449.1a55df1e@xps13>
        <a5650f33b493b987d45525ea57fdfd8a@codeaurora.org>
        <38da9d1d4a96f1b42ba0b194da265e6b@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

mdalam@codeaurora.org wrote on Wed, 24 Feb 2021 10:09:48 +0530:

> On 2021-02-24 01:13, mdalam@codeaurora.org wrote:
> > On 2021-02-23 22:04, Miquel Raynal wrote:  
> >> Hello,  
> >> >> Md Sadre Alam <mdalam@codeaurora.org> wrote on Tue, 23 Feb 2021  
> >> 01:34:27 +0530:  
> >> >>> From QPIC version 2.0 onwards new register got added to read last  
> >> >>                                a new  
> >> >>> codeword. This change will add the READ_LOCATION_LAST_CW_n register.  
> >> >>             Add support for this READ_LOCATION_LAST_CW_n register.  
> >> >>> >>> For first three code word READ_LOCATION_n register will be  
> >>> use.For last code word READ_LOCATION_LAST_CW_n register will be
> >>> use.  
> >> >> "  
> >> In the case of QPIC v2, codewords 0, 1 and 2 will be accessed through
> >> READ_LOCATION_n, while codeword 3 will be accessed through
> >> READ_LOCATION_LAST_CW_n.
> >> "  
> >> >> When I read my own sentence, I feel that there is something wrong.  
> >> If there are only 4 codewords, I guess a QPIC v2 is able to use
> >> READ_LOCATION_3 or READ_LOCATION_LAST_CW_0 interchangeably. Isn't it?  
> >> >> I guess the point of having these "last_cw_n" registers is to support  
> >> up to 8 codewords, am I wrong? If this the case, the current patch
> >> completely fails doing that I don't get the point of such change.  
> > 
> > This register is only use to read last code word.
> > 
> > I have address all the comments from all the previous sub sequent
> > patches and pushed
> > all patches in only one series.
> > 
> > Please check.  
> 
>   The registers READ_LOCATION & READ_LOCATION_LAST are not associated with number of code words.
>   These two registers are used to access the location inside a code word.

Ok. Can you please explain what is a location then? Or point me to a
datasheet that explains it.

Bottom line question: why having READ_LOCATION_0, _1,... an
READ_LOCATION_LAST_0, _1, etc?

> So whether we are having 4 code words
>   or 8 code words it doesn't matter. If we wanted access the location within normal code word we have to
>   use READ_LOCATION register and if we wanted to access location in last code word then we have to use
>   READ_LOCATION_LAST.
> >   
> >> >>> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>  

Thanks,
Miquèl
