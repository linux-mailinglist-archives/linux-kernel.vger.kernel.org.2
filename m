Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499F639AB82
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 22:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhFCUJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 16:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCUJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 16:09:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07BBD613D7;
        Thu,  3 Jun 2021 20:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622750835;
        bh=xWOfmDOvKdhrWNFeqpdIkMU9MPu5knIBzT/+q1yRejo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WJiYXB/ORfPow8HKiWAVTSL711JV1C0dV4Hcxgt1448bqCv0OD9SVh3tdXMBqryqP
         YAcN5gh9WCzHpncZn1knzx1D5Wi1Z94ToGRojheqnS4MDUOQAnYDFMqeurRfqmDJ60
         VGr5zr34a6CzpluKhL9PMo8zB5zCJtu0j4H7xB4BfXAKdcDiwe9TIgQPS9bheGlzJ+
         ykc9Zj+0LZKuqgPhYTb+suLwV8r27CAtFdSHdEeNql3C/4qzw6KwRF1jpumx5k7z6z
         acC43r4s7b6TKbMcLJd9ZrE8YfFWOlqGfkQbgyH4oIxjvpZ0UdlwDmDpM40Meyz8ny
         tb9L4E473Jctg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8b763492-b2b3-93d3-9801-2f2f0ec90241@lucaceresoli.net>
References: <20210527211647.1520720-1-luca@lucaceresoli.net> <162262084596.4130789.198191855440093780@swboyd.mtv.corp.google.com> <8b763492-b2b3-93d3-9801-2f2f0ec90241@lucaceresoli.net>
Subject: Re: [PATCH RESEND] clk: vc5: fix output disabling when enabling a FOD
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Adam Ford <aford173@gmail.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-clk@vger.kernel.org
Date:   Thu, 03 Jun 2021 13:07:13 -0700
Message-ID: <162275083380.1835121.17366140869706759167@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Luca Ceresoli (2021-06-03 01:44:57)
> Hi Stephen,
>=20
> On 02/06/21 10:00, Stephen Boyd wrote:
> > Quoting Luca Ceresoli (2021-05-27 14:16:47)
> >> On 5P49V6965, when an output is enabled we enable the corresponding
> >> FOD. When this happens for the first time, and specifically when writi=
ng
> >> register VC5_OUT_DIV_CONTROL in vc5_clk_out_prepare(), all other outpu=
ts
> >> are stopped for a short time and then restarted.
> >>
> >> According to Renesas support this is intended: "The reason for that is=
 VC6E
> >> has synced up all output function".
> >>
> >> This behaviour can be disabled at least on VersaClock 6E devices, of w=
hich
> >> only the 5P49V6965 is currently implemented by this driver. This requi=
res
> >> writing bit 7 (bypass_sync{1..4}) in register 0x20..0x50.  Those regis=
ters
> >> are named "Unused Factory Reserved Register", and the bits are documen=
ted
> >> as "Skip VDDO<N> verification", which does not clearly explain the rel=
ation
> >> to FOD sync. However according to Renesas support as well as my testing
> >> setting this bit does prevent disabling of all clock outputs when enab=
ling
> >> a FOD.
> >>
> >> See "VersaClock =C2=AE 6E Family Register Descriptions and Programming=
 Guide"
> >> (August 30, 2018), Table 116 "Power Up VDD check", page 58:
> >> https://www.renesas.com/us/en/document/mau/versaclock-6e-family-regist=
er-descriptions-and-programming-guide
> >>
> >> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> >> Reviewed-by: Adam Ford <aford173@gmail.com>
> >>
> >> ---
> >=20
> > Any Fixes tag for this patch?
>=20
> I didn't add any as there is no commit that is clearly introducing the
> problem. This patch fixes a behavior of the chip, which is there by
> design by causes problems in some use cases.
>=20
> If a Fixes tag is required than I guess it should be the commit adding
> support for the 5P49V6965, which is the only supported variant of VC[56]
> having having the problematic behavior _and_ the reserved register bits
> to prevent it. However I hardly could blame the author of that code for
> such a "peculiar" chip behaviour. Do you still want me to add such a tag?

I tend to liberally apply the Fixes tag if something is being fixed. It
helps understand that the patch is not introducing a new feature and
when the incorrect code was introduced. I can slap on a Fixes tag
myself, just not sure what to do.
