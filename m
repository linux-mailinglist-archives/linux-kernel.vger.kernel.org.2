Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4301132AB95
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837051AbhCBUaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:30:22 -0500
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:60110 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344390AbhCBRtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:49:02 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 1C213180322EC;
        Tue,  2 Mar 2021 17:46:09 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id E7A51181B3E89;
        Tue,  2 Mar 2021 17:42:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:973:988:989:1260:1261:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1544:1593:1594:1605:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:3872:3874:4031:5007:6996:7652:7903:10004:11026:11658:11914:12043:12296:12297:12438:12760:12986:13018:13019:13161:13184:13229:13439:13869:14093:14097:14659:14721:21063:21080:21433:21451:21627:21740:21939:21972:30005:30012:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: home60_3c159ee276be
X-Filterd-Recvd-Size: 4972
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue,  2 Mar 2021 17:42:52 +0000 (UTC)
Message-ID: <053b06c47f08631675c295b5c893b90be4248347.camel@perches.com>
Subject: linux-kernel janitorial RFP: Mark static arrays as const
From:   Joe Perches <joe@perches.com>
To:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 02 Mar 2021 09:42:51 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a possible opportunity to reduce data usage in the kernel.

$ git grep -P -n '^static\s+(?!const|struct)(?:\w+\s+){1,3}\w+\s*\[\s*\]' drivers/ | \
  grep -v __initdata | \
  wc -l
3250

Meaning there are ~3000 declarations of arrays with what appears to be
file static const content that are not marked const.

So there are many static arrays that could be marked const to move the
compiled object code from data to text minimizing the total amount of
exposed r/w data.

However, I do not know of a mechanism using coccinelle to determine
whether or not any of these static declarations are ever modified.

So it appears that each instance of these declarations might need
manual inspection.

But for arrays declared inside functions, it's much more likely that
the static declaration without const is done with the intent to modify
the array:

(note the difference in the git grep with a leading '^\s+')

$ git grep -Pn '^\s+static\s+(?!const|struct)(?:\w+\s+){1,3}\w+\s*\[\s*\]' drivers/ | \
  grep -v __initdata | \
  wc -l
323

------------- For instance: (head -10 of the git grep for file statics)

drivers/accessibility/speakup/keyhelp.c:18:static u_short masks[] = { 32, 16, 8, 4, 2, 1 };
drivers/accessibility/speakup/keyhelp.c:26:static u_char funcvals[] = {
drivers/accessibility/speakup/main.c:2059:static spkup_hand spkup_handler[] = {
drivers/accessibility/speakup/speakup_acntpc.c:35:static unsigned int synth_portlist[] = { 0x2a8, 0 };
drivers/accessibility/speakup/speakup_decpc.c:133:static int synth_portlist[] = { 0x340, 0x350, 0x240, 0x250, 0 };
drivers/accessibility/speakup/speakup_dectlk.c:110:static int ap_defaults[] = {122, 89, 155, 110, 208, 240, 200, 106, 306};
drivers/accessibility/speakup/speakup_dectlk.c:111:static int g5_defaults[] = {86, 81, 86, 84, 81, 80, 83, 83, 73};
drivers/accessibility/speakup/speakup_dtlk.c:34:static unsigned int synth_portlist[] = {
drivers/accessibility/speakup/speakup_keypc.c:34:static unsigned int synth_portlist[] = { 0x2a8, 0 };
drivers/acpi/ac.c:137:static enum power_supply_property ac_props[] = {

For drivers/accessibility/speakup/keyhelp.c:18:static u_short masks[] = { 32, 16, 8, 4, 2, 1 };

masks is only used in static function say_key and should be const and
perhaps the declaration might be better moved into that function.

For drivers/accessibility/speakup/keyhelp.c:26:static u_char funcvals[] = {

funcvals is only used in static function spk_handle_help and should be const
and perhaps the declaration might be better moved into that function.

For drivers/accessibility/speakup/main.c:2059:static spkup_hand spkup_handler[] = {

spkup_handler is only used in static function do_spkup and should be const
and perhaps the declaration might be better moved into that function.

etc... for speakup

For drivers/acpi/ac.c:137:static enum power_supply_property ac_props[] = {

array ac_props is assigned as a reference in acpi_ac_add as a 
"const enum power_supply_property *" member of a struct power_supply_desc.

------------- For instance: (head -10 of the git grep for function statics)

drivers/acpi/apei/apei-base.c:781:	static u8 whea_uuid_str[] = "ed855e0c-6c90-47bf-a62a-26de0fc5ad5c";
drivers/block/amiflop.c:1051:	static unsigned char CRCTable1[] = {
drivers/block/amiflop.c:1070:	static unsigned char CRCTable2[] = {
drivers/block/drbd/drbd_nl.c:872:	static char units[] = { 'K', 'M', 'G', 'T', 'P', 'E' };
drivers/block/drbd/drbd_proc.c:224:	static char write_ordering_chars[] = {
drivers/block/drbd/drbd_receiver.c:4363:	static enum drbd_conns c_tab[] = {
drivers/char/pcmcia/synclink_cs.c:3717:	static unsigned char patterns[] =
drivers/cpufreq/intel_pstate.c:1515:	static int silvermont_freq_table[] = {
drivers/cpufreq/intel_pstate.c:1530:	static int airmont_freq_table[] = {
drivers/dma/xgene-dma.c:360:	static u8 flyby_type[] = {

Some of these could be const, but some could not.  For instance:

For drivers/acpi/apei/apei-base.c:781:	static u8 whea_uuid_str[] = "ed855e0c-6c90-47bf-a62a-26de0fc5ad5c";

whea_uuid_str is assigned as a reference in "int apei_osc_setup(void)"
a struct acpi_osc_context where .uuid_str is not declared as const char *.




