Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A0F30D936
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhBCLyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:54:18 -0500
Received: from m12-14.163.com ([220.181.12.14]:57387 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234057AbhBCLyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=Ql/Fl
        kYe33gSyZXRWYjYiF8nirZv149/fAHCmTdjR2M=; b=guzMY7/izVvYzxRuxydsr
        bW3hVGzfG/qrwupLHudrhLvB2wwBcNxaQ/B+MGHxWlE0qjZyGTOEmP5TQX6nRkaN
        eMBXTToNaZn9VfCLAV5Lx0Fdvsn60AmgWUVZJOrEX61kpT19Fq6FLln5O1hgeDXD
        7ZppFuvOL8zv+XohostxiQ=
Received: from localhost (unknown [119.137.55.230])
        by smtp10 (Coremail) with SMTP id DsCowAAnh3+eihpgeNTRjA--.924S2;
        Wed, 03 Feb 2021 19:35:59 +0800 (CST)
Date:   Wed, 3 Feb 2021 19:36:09 +0800
From:   wengjianfeng <samirweng1979@163.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     jason.wessel@windriver.com, dianders@chromium.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
Subject: Re: [PATCH] kernel: debug: fix typo issue
Message-ID: <20210203193609.00007678@163.com>
In-Reply-To: <20210203112359.cdy73gw4wip5cnyn@maple.lan>
References: <20210203081034.9004-1-samirweng1979@163.com>
        <20210203112359.cdy73gw4wip5cnyn@maple.lan>
Organization: yulong
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DsCowAAnh3+eihpgeNTRjA--.924S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr18Jr43AFWrKFyDKry8Zrb_yoW8Wr4UpF
        WxKa4rKF4xJry0ga1SyanIqFyjg34rtw4v9rZ0yas5CF15ZF97XF4kWay5ur4DZrWkWry5
        tr4qga48ZwnrXFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j79N3UUUUU=
X-Originating-IP: [119.137.55.230]
X-CM-SenderInfo: pvdpx25zhqwiqzxzqiywtou0bp/1tbiER8usV7+2s8ymgAAsM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Feb 2021 11:23:59 +0000
Daniel Thompson <daniel.thompson@linaro.org> wrote:

> On Wed, Feb 03, 2021 at 04:10:34PM +0800, samirweng1979 wrote:
> > From: wengjianfeng <wengjianfeng@yulong.com>
> > 
> > change 'regster' to 'register'.
> > 
> > Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>
> 
> It looks like the Subject line might not be correct for this patch?
> 
> Is it really the first time this patch has been circulated or should
> it have been tagged RESEND or v2?
> 
> 
> Daniel.
> 
> 
> > ---
> >  kernel/debug/gdbstub.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> > index a77df59..e149a0a 100644
> > --- a/kernel/debug/gdbstub.c
> > +++ b/kernel/debug/gdbstub.c
> > @@ -595,7 +595,7 @@ static char *gdb_hex_reg_helper(int regnum,
> > char *out) dbg_reg_def[i].size);
> >  }
> >  
> > -/* Handle the 'p' individual regster get */
> > +/* Handle the 'p' individual register get */
> >  static void gdb_cmd_reg_get(struct kgdb_state *ks)
> >  {
> >  	unsigned long regnum;
> > @@ -610,7 +610,7 @@ static void gdb_cmd_reg_get(struct kgdb_state
> > *ks) gdb_hex_reg_helper(regnum, remcom_out_buffer);
> >  }
> >  
> > -/* Handle the 'P' individual regster set */
> > +/* Handle the 'P' individual register set */
> >  static void gdb_cmd_reg_set(struct kgdb_state *ks)
> >  {
> >  	unsigned long regnum;
> > -- 
> > 1.9.1
> > 
> > 


Hi Daniel,
   The patch was first sent on January 25, but nobody relply me, so I
   just resend the patch, and the patch is the same as last time,does I
   need add RESEND tag? thanks.

