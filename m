Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAA332AE2A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360650AbhCBWXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:23:04 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:36757 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351067AbhCBVmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:42:42 -0500
X-IronPort-AV: E=Sophos;i="5.81,217,1610406000"; 
   d="scan'208";a="495775783"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 22:41:32 +0100
Date:   Tue, 2 Mar 2021 22:41:32 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Cocci] linux-kernel janitorial RFP: Mark static arrays as
 const
In-Reply-To: <053b06c47f08631675c295b5c893b90be4248347.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2103022241050.2906@hadrien>
References: <053b06c47f08631675c295b5c893b90be4248347.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Mar 2021, Joe Perches wrote:

> Here is a possible opportunity to reduce data usage in the kernel.

Does it actually reduce data usage?

julia

>
> $ git grep -P -n '^static\s+(?!const|struct)(?:\w+\s+){1,3}\w+\s*\[\s*\]' drivers/ | \
>   grep -v __initdata | \
>   wc -l
> 3250
>
> Meaning there are ~3000 declarations of arrays with what appears to be
> file static const content that are not marked const.
>
> So there are many static arrays that could be marked const to move the
> compiled object code from data to text minimizing the total amount of
> exposed r/w data.
>
> However, I do not know of a mechanism using coccinelle to determine
> whether or not any of these static declarations are ever modified.
>
> So it appears that each instance of these declarations might need
> manual inspection.
>
> But for arrays declared inside functions, it's much more likely that
> the static declaration without const is done with the intent to modify
> the array:
>
> (note the difference in the git grep with a leading '^\s+')
>
> $ git grep -Pn '^\s+static\s+(?!const|struct)(?:\w+\s+){1,3}\w+\s*\[\s*\]' drivers/ | \
>   grep -v __initdata | \
>   wc -l
> 323
>
> ------------- For instance: (head -10 of the git grep for file statics)
>
> drivers/accessibility/speakup/keyhelp.c:18:static u_short masks[] = { 32, 16, 8, 4, 2, 1 };
> drivers/accessibility/speakup/keyhelp.c:26:static u_char funcvals[] = {
> drivers/accessibility/speakup/main.c:2059:static spkup_hand spkup_handler[] = {
> drivers/accessibility/speakup/speakup_acntpc.c:35:static unsigned int synth_portlist[] = { 0x2a8, 0 };
> drivers/accessibility/speakup/speakup_decpc.c:133:static int synth_portlist[] = { 0x340, 0x350, 0x240, 0x250, 0 };
> drivers/accessibility/speakup/speakup_dectlk.c:110:static int ap_defaults[] = {122, 89, 155, 110, 208, 240, 200, 106, 306};
> drivers/accessibility/speakup/speakup_dectlk.c:111:static int g5_defaults[] = {86, 81, 86, 84, 81, 80, 83, 83, 73};
> drivers/accessibility/speakup/speakup_dtlk.c:34:static unsigned int synth_portlist[] = {
> drivers/accessibility/speakup/speakup_keypc.c:34:static unsigned int synth_portlist[] = { 0x2a8, 0 };
> drivers/acpi/ac.c:137:static enum power_supply_property ac_props[] = {
>
> For drivers/accessibility/speakup/keyhelp.c:18:static u_short masks[] = { 32, 16, 8, 4, 2, 1 };
>
> masks is only used in static function say_key and should be const and
> perhaps the declaration might be better moved into that function.
>
> For drivers/accessibility/speakup/keyhelp.c:26:static u_char funcvals[] = {
>
> funcvals is only used in static function spk_handle_help and should be const
> and perhaps the declaration might be better moved into that function.
>
> For drivers/accessibility/speakup/main.c:2059:static spkup_hand spkup_handler[] = {
>
> spkup_handler is only used in static function do_spkup and should be const
> and perhaps the declaration might be better moved into that function.
>
> etc... for speakup
>
> For drivers/acpi/ac.c:137:static enum power_supply_property ac_props[] = {
>
> array ac_props is assigned as a reference in acpi_ac_add as a
> "const enum power_supply_property *" member of a struct power_supply_desc.
>
> ------------- For instance: (head -10 of the git grep for function statics)
>
> drivers/acpi/apei/apei-base.c:781:	static u8 whea_uuid_str[] = "ed855e0c-6c90-47bf-a62a-26de0fc5ad5c";
> drivers/block/amiflop.c:1051:	static unsigned char CRCTable1[] = {
> drivers/block/amiflop.c:1070:	static unsigned char CRCTable2[] = {
> drivers/block/drbd/drbd_nl.c:872:	static char units[] = { 'K', 'M', 'G', 'T', 'P', 'E' };
> drivers/block/drbd/drbd_proc.c:224:	static char write_ordering_chars[] = {
> drivers/block/drbd/drbd_receiver.c:4363:	static enum drbd_conns c_tab[] = {
> drivers/char/pcmcia/synclink_cs.c:3717:	static unsigned char patterns[] =
> drivers/cpufreq/intel_pstate.c:1515:	static int silvermont_freq_table[] = {
> drivers/cpufreq/intel_pstate.c:1530:	static int airmont_freq_table[] = {
> drivers/dma/xgene-dma.c:360:	static u8 flyby_type[] = {
>
> Some of these could be const, but some could not.  For instance:
>
> For drivers/acpi/apei/apei-base.c:781:	static u8 whea_uuid_str[] = "ed855e0c-6c90-47bf-a62a-26de0fc5ad5c";
>
> whea_uuid_str is assigned as a reference in "int apei_osc_setup(void)"
> a struct acpi_osc_context where .uuid_str is not declared as const char *.
>
>
>
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
