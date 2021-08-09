Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFD23E4B15
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 19:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhHIRpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 13:45:05 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:53090 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234804AbhHIRor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:44:47 -0400
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 72074837F24F;
        Mon,  9 Aug 2021 17:44:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 8E23D18A60E;
        Mon,  9 Aug 2021 17:44:03 +0000 (UTC)
Message-ID: <6b7de60b83cc5ce930736c6158a648b91f647c0b.camel@perches.com>
Subject: Re: [PATCH] mailmap: update email address of Matthias Fuchs
From:   Joe Perches <joe@perches.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     socketcan@esd.eu,
        Stefan =?ISO-8859-1?Q?M=E4tje?= <Stefan.Maetje@esd.eu>
Date:   Mon, 09 Aug 2021 10:44:02 -0700
In-Reply-To: <20210806104833.102081-1-mkl@pengutronix.de>
References: <20210806104833.102081-1-mkl@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E23D18A60E
X-Spam-Status: No, score=1.35
X-Stat-Signature: iyq45x6aym35xrjhhkxaxtqbjsfp4pk5
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+QLdTo4QbQjpDboPsq75yaswuJwa1HyOk=
X-HE-Tag: 1628531043-583688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-08-06 at 12:48 +0200, Marc Kleine-Budde wrote:
> Matthias Fuchs's email isn't valid anymore. Use the newly created role
> account instead.
> 
> Cc: socketcan@esd.eu
> Cc: Stefan Mätje <Stefan.Maetje@esd.eu>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index a35ae244dfda..86a630d26cfb 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -330,6 +330,7 @@ Shuah Khan <shuah@kernel.org> <shuahkh@osg.samsung.com>
>  Shuah Khan <shuah@kernel.org> <shuah.kh@samsung.com>
>  Simon Arlott <simon@octiron.net> <simon@fire.lp0.eu>
>  Simon Kelley <simon@thekelleys.org.uk>
> +<socketcan@esd.eu> <matthias.fuchs@esd.eu>

Please add a name not only the email address and place the entry
in alphabetical order by name.

>  Stéphane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
>  Stephen Hemminger <shemminger@osdl.org>
>  Steve Wise <larrystevenwise@gmail.com> <swise@chelsio.com>


