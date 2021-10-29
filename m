Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A882E43F586
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 05:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhJ2Dsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 23:48:47 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39419 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231611AbhJ2Dsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 23:48:45 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id B08B95C01C2;
        Thu, 28 Oct 2021 23:46:16 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute2.internal (MEProxy); Thu, 28 Oct 2021 23:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=4ecynQE/mi8JhloxKEfsAbzg5Np3viO
        3Lizq0tTL4VY=; b=X2X2PCsmSdbzcEeXZWbW+ZXCPG7jmpVFtvff0XV+5qtXwQY
        +rymTSK1eEb7us4kdoRhOO45meBl6tUxhn5VGOA9PVMvkVJVLpz7yemP5tibrz5g
        LeccPkKhAGPB6grIs+vsPeVWAwSEV66B1RtTI9qQ8ZF8xVZaUH+PVFNYT3NJ19iU
        c5R+WmmytsLvgjm83EMTRqW0aI2ml8xSqeMJQcZZmTqGPNd/qD2xHwb1hSeRNX+N
        7dDQJNc27WrA25ygdXdtnB1jQT+BFzPRpg8s9E45skQv1kiuLjZs8LMldme51/r+
        /J8yDGbZXOYhk/shNWsvOpJhPqpKOn07SDFjraA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4ecynQ
        E/mi8JhloxKEfsAbzg5Np3viO3Lizq0tTL4VY=; b=PuVcCq+viEy2hxryrBJalc
        8GpInWN5x6d97JrHckjCLXXsvpNvE2snvQadDk/4kWLlbuUMx+9NrRixpw1RRAuO
        F/ud8NXOykyOgey9LdBhlmOx5HoPTIyfzVuBf5720h4V+dq7O66r5N+uAbcAgFHw
        Z2k/bVGeLChB5wF/Q44Oa8H8JGZj8uP3C8NVSzratoIIbKg3776YuW8X8m8lAjwG
        h1OWNdeKFJ7GATWDLP0+tcFKbKaUhhfdb8NqE0P4i4Wt7X08my6GxraaKMmmSDl6
        UwUJO360tr+doufy2J6CANys0TyWwzF7eji36GLIibcXiBji7wa0BSp6sqDAuyMw
        ==
X-ME-Sender: <xms:hm57YejhuTlnRN1NAZ0MKP_Lhu2xfrzr93qBDeq0Dru7vCWcqT2RLQ>
    <xme:hm57YfC78U7bBIDe1YJ33k9H4KDGXX1MvETuTGB6Lig_iDQTGt3cJu7D4sf6J1WJW
    dSJmGvxvEq_LxDWyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdeggedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:hm57YWH9ZiQczwe8vRqUNtLmjS3MBCBW72L2-SSXY1iED6htS_WJJw>
    <xmx:hm57YXR0zv--y_gmEdJVfBhM4jJKi2ZSOIi5acp8DV6onfiaIWiNAg>
    <xmx:hm57YbyRu5YjlOIEkJraZ93pT8h0VjDRp1MK0ksGUQXDju_0suz4xg>
    <xmx:iG57Yb-E3BcvJ1T9CefPUjlYNu9YPgxm-RUcMpe5u6IZuKJFKLVSTw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 73114AC0DD1; Thu, 28 Oct 2021 23:46:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <ad15c868-de54-41c2-8d3c-716c33b7aa8c@www.fastmail.com>
In-Reply-To: <HK0PR06MB338025A6EC2AE11D25C34998F2B29@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20210925022354.10297-1-ryan_chen@aspeedtech.com>
 <CACPK8Xct9rWEu40XHWjo_uY9P7dJ=U5LBM+O3KjmjNL+9yD5QQ@mail.gmail.com>
 <HK0PR06MB338025A6EC2AE11D25C34998F2B29@HK0PR06MB3380.apcprd06.prod.outlook.com>
Date:   Fri, 29 Oct 2021 14:15:54 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Ryan Chen" <ryan_chen@aspeedtech.com>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3] clk:aspeed:Fix AST2600 hpll calculate formula
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Oct 2021, at 18:02, Ryan Chen wrote:
>> -----Original Message-----
>> From: Joel Stanley <joel@jms.id.au>
>> Sent: Friday, October 8, 2021 12:06 PM
>> To: Ryan Chen <ryan_chen@aspeedtech.com>
>> Cc: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
>> <sboyd@kernel.org>; Andrew Jeffery <andrew@aj.id.au>;
>> linux-clk@vger.kernel.org; Linux Kernel Mailing List
>> <linux-kernel@vger.kernel.org>
>> Subject: Re: [PATCHv3] clk:aspeed:Fix AST2600 hpll calculate formula
>> 
>> On Sat, 25 Sept 2021 at 02:24, Ryan Chen <ryan_chen@aspeedtech.com>
>> wrote:
>> >
>> 
>> A few notes on process:
>> 
>> > v2 -> v3: change else than if to directly else if
>> > v1 -> v2: add Fixes commit hash
>> 
>> As this is normally information for reviewers to know what you've changed
>> since the last version, we normally put this below the --- in the patch, which
>> means it is not included in the commit message.
>> 
>> Also we put a space between the PATCH and v3 in the subject. If you use the
>> tools, it will generate this for you:
>> 
>> git format-patch -v3 -1 --to=...
>> 
>> >
>> > AST2600 HPLL calculate formula [SCU200] HPLL Numerator(M): have fixed
>> > value depend on SCU strap.
>> > M = SCU500[10] ? 0x5F : SCU500[8] ? 0xBF : SCU200[12:0]
>> 
>> I recommend adding to the commit message the text from my first review:
>> 
>> From the datasheet:
>> 
>> CPU frequency selection
>> 000 1.2GHz
>> 001 1.6GHz
>> 010 1.2GHz
>> 011 1.6GHz
>> 100 800MHz
>> 101 800MHz
>> 110 800MHz
>> 111 800MHz
>> 
>> So when the system is running at 800MHz or 1.6GHz, the value for the
>> numerator (m) in SCU204 is incorrect, and must be overridden.
>
> Yes, SCU204 will be overridden by chip design.
> Let me clarify m is in SCU200[12:0] not SCU204. SCU204 is NB not 
> related with freq.
>
>> 
>> >
>> > if SCU500[10] = 1, M=0x5F.
>> > else if SCU500[10]=0 & SCU500[8]=1, M=0xBF.
>> > others (SCU510[10]=0 and SCU510[8]=0)
>> > depend on SCU200[12:0] (default 0x8F) register setting.
>> >
>> > HPLL Denumerator (N) =  SCU200[18:13] (default 0x2)
>> > HPLL Divider (P)         =      SCU200[22:19] (default 0x0)
>> >
>> > Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
>> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>> > ---
>> >  drivers/clk/clk-ast2600.c | 28 +++++++++++++++++++++++++++-
>> >  1 file changed, 27 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
>> > index 085d0a18b2b6..d30188355aaf 100644
>> > --- a/drivers/clk/clk-ast2600.c
>> > +++ b/drivers/clk/clk-ast2600.c
>> > @@ -169,6 +169,32 @@ static const struct clk_div_table
>> > ast2600_div_table[] = {  };
>> >
>> >  /* For hpll/dpll/epll/mpll */
>> > +static struct clk_hw *ast2600_calc_hpll(const char *name, u32 val) {
>> > +       unsigned int mult, div;
>> > +       u32 hwstrap = readl(scu_g6_base + ASPEED_G6_STRAP1);
>> > +
>> > +       if (val & BIT(24)) {
>> > +               /* Pass through mode */
>> > +               mult = div = 1;
>> > +       } else {
>> > +               /* F = 25Mhz * [(M + 2) / (n + 1)] / (p + 1) */
>> > +               u32 m = val  & 0x1fff;
>> > +               u32 n = (val >> 13) & 0x3f;
>> > +               u32 p = (val >> 19) & 0xf;
>> > +
>> 
>> Add a comment:
>> 
>> /* If the CPU is running at 800Mhz. */
>> 
>> > +               if (hwstrap & BIT(10))
>> > +                       m = 0x5F;
>> 
>> /* If the CPU is running at 1600Mhz. */
>> 
>> > +               else if (hwstrap & BIT(8))
>> > +                       m = 0xBF;
>> 
>> 
>> Or you could copy what I suggested in the first patch, and write it like this,
>> which I think is clear:
>> 
>> ff (hwstrap & BIT(10)) {
>>     /* CPU running at 800MHz */
>>    m = 95;
>> } else if (hwstrap & BIT(10)) {
>>     /* CPU running at 1.6GHz */
>>   m  = 191;
>> } else {
>>    /* CPU running at 1.2Ghz */
>>   m = val  & 0x1fff;
>> }
>
> How about following 
>
> ff (hwstrap & BIT(10)) {
>     /* CPU running at 800MHz */
>     m = 0x5F;
> } else if (hwstrap & BIT(10)) {

This is the same condition as the `if` above. That doesn't seem right.

>     /* CPU running at 1.6GHz */
>     m = 0xBF;
> } else {
>    /* CPU running at 1.2Ghz */
>    m = val  & 0x1fff;
> }
>
>> 
