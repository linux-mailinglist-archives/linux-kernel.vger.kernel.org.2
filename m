Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C0C34BC0E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 12:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhC1Kch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 06:32:37 -0400
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:58762 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230196AbhC1KcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 06:32:16 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 743CDB9FF;
        Sun, 28 Mar 2021 10:32:15 +0000 (UTC)
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA id 7436A1D42F5;
        Sun, 28 Mar 2021 10:32:14 +0000 (UTC)
Message-ID: <6caae542c6f295a47b1012738b3b35055cf17cc4.camel@perches.com>
Subject: Re: [PATCH] kconfig: nconf: stop endless search-up loops
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Mihai Moldovan <ionic@ionic.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 28 Mar 2021 03:32:13 -0700
In-Reply-To: <362edad0-daea-1f56-bed3-b1df174cbbf1@infradead.org>
References: <20210327120155.500-1-ionic@ionic.de>
         <1ca3a90f-799e-d917-370e-1475e33cdb14@infradead.org>
         <111c5853-e488-0aaa-18e9-36792b648427@ionic.de>
         <362edad0-daea-1f56-bed3-b1df174cbbf1@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7436A1D42F5
X-Spam-Status: No, score=0.10
X-Stat-Signature: 4nigk8rin35oj356persx9fyc737ioq1
X-HE-Tag: 1616927534-838904
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-03-27 at 15:26 -0700, Randy Dunlap wrote:
> On 3/27/21 3:12 PM, Mihai Moldovan wrote:
> > * On 3/27/21 4:58 PM, Randy Dunlap wrote:
> > > On 3/27/21 5:01 AM, Mihai Moldovan wrote:
> > > > +		if ((-1 == index) && (index == match_start))
> > > 
> > > checkpatch doesn't complain about this (and I wonder how it's missed), but
> > > kernel style is (mostly) "constant goes on right hand side of comparison",
> > > so
> > > 		if ((index == -1) &&
> > 
> > I can naturally send a V2 with that swapped.
> > 
> > To my rationale: I made sure to use checkpatch, saw that it was accepted and
> > even went for a quick git grep -- '-1 ==', which likewise returned enough
> > results for me to call this consistent with the current code style.
> > 
> > Maybe those matches were just frowned-upon, but forgotten-to-be-critized
> > examples of this pattern being used.
> 
> There is a test for it in checkpatch.pl but I also used checkpatch.pl
> without it complaining, so I don't know what it takes to make the script
> complain.
> 
> 			if ($lead !~ /(?:$Operators|\.)\s*$/ &&
> 			    $to !~ /^(?:Constant|[A-Z_][A-Z0-9_]*)$/ &&
> 			    WARN("CONSTANT_COMPARISON",
> 				 "Comparisons should place the constant on the right side of the test\n" . $herecurr) &&

Negative values aren't parsed well by the silly script as checkpatch
isn't a real parser.

Basically, checkpatch only recognizes positive ints as constants.

So it doesn't recognize uses like:

	a * -5 > b

It doesn't parse -5 as a negative constant.

Though here it does seem the line with
 			    $to !~ /^(?:Constant|[A-Z_][A-Z0-9_]*)$/ &&
should be
 			    $to !~ /^(?:$Constant|[A-Z_][A-Z0-9_]*)$/ &&

You are welcome to try to improve checkpatch, but it seems non-trivial
and a relatively uncommon use in the kernel, so I won't.

Most all of the existing uses seem to be in drivers/scsi/pm8001/pm8001_hwi.c

$ git grep -P 'if\s*\(\s*\-\d+\s*(?:<=|>=|==|<|>)' -- '*.[ch]'
drivers/media/i2c/msp3400-driver.c:		if (-1 == scarts[out][in + 1])
drivers/media/pci/bt8xx/bttv-driver.c:		if (-1 == formats[i].fourcc)
drivers/media/pci/saa7134/saa7134-tvaudio.c:	if (-1 == secondary)
drivers/media/pci/saa7146/mxb.c:			if (-1 == mxb_saa7740_init[i].length)
drivers/media/usb/s2255/s2255drv.c:		if (-1 == formats[i].fourcc)
drivers/net/ieee802154/mrf24j40.c:	} else if (-1000 >= mbm && mbm > -2000) {
drivers/net/ieee802154/mrf24j40.c:	} else if (-2000 >= mbm && mbm > -3000) {
drivers/net/ieee802154/mrf24j40.c:	} else if (-3000 >= mbm && mbm > -4000) {
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c:	if (-1 == *gain_index) {
drivers/parisc/eisa_enumerator.c:		if (-1==init_slot(i+1, es)) {
drivers/scsi/pm8001/pm8001_hwi.c:	if (-1 == pm8001_bar4_shift(pm8001_ha,
drivers/scsi/pm8001/pm8001_hwi.c:	if (-1 == pm8001_bar4_shift(pm8001_ha,
drivers/scsi/pm8001/pm8001_hwi.c:	if (-1 == pm8001_bar4_shift(pm8001_ha,
drivers/scsi/pm8001/pm8001_hwi.c:	if (-1 == pm8001_bar4_shift(pm8001_ha,
drivers/scsi/pm8001/pm8001_hwi.c:		if (-1 == pm8001_bar4_shift(pm8001_ha, GSM_SM_BASE)) {
drivers/scsi/pm8001/pm8001_hwi.c:	if (-1 == check_fw_ready(pm8001_ha)) {
drivers/scsi/pm8001/pm8001_hwi.c:		if (-1 == pm8001_bar4_shift(pm8001_ha, GSM_SM_BASE)) {
drivers/scsi/pm8001/pm8001_hwi.c:		if (-1 == pm8001_bar4_shift(pm8001_ha, RB6_ACCESS_REG)) {
drivers/scsi/pm8001/pm8001_hwi.c:	if (-1 == pm8001_bar4_shift(pm8001_ha, MBIC_AAP1_ADDR_BASE)) {
drivers/scsi/pm8001/pm8001_hwi.c:	if (-1 == pm8001_bar4_shift(pm8001_ha, MBIC_IOP_ADDR_BASE)) {
drivers/scsi/pm8001/pm8001_hwi.c:	if (-1 == pm8001_bar4_shift(pm8001_ha, GSM_ADDR_BASE)) {
drivers/scsi/pm8001/pm8001_hwi.c:	if (-1 == pm8001_bar4_shift(pm8001_ha, GPIO_ADDR_BASE)) {
drivers/scsi/pm8001/pm8001_hwi.c:	if (-1 == pm8001_bar4_shift(pm8001_ha, SPC_TOP_LEVEL_ADDR_BASE)) {
drivers/scsi/pm8001/pm8001_hwi.c:	if (-1 == pm8001_bar4_shift(pm8001_ha, GSM_ADDR_BASE)) {
drivers/scsi/pm8001/pm8001_hwi.c:	if (-1 == pm8001_bar4_shift(pm8001_ha, SPC_TOP_LEVEL_ADDR_BASE)) {
drivers/scsi/pm8001/pm8001_hwi.c:				if (-1 == pm8001_bar4_shift(pm8001_ha,
drivers/scsi/pm8001/pm8001_hwi.c:				if (-1 == pm80xx_bar4_shift(pm8001_ha,
drivers/scsi/pm8001/pm8001_hwi.c:	if (-1 == pm8001_bar4_shift(pm8001_ha, 0))
drivers/scsi/pm8001/pm8001_sas.c:			if (-1 == pm8001_bar4_shift(pm8001_ha,
drivers/scsi/pm8001/pm80xx_hwi.c:	if (-1 == check_fw_ready(pm8001_ha)) {
drivers/scsi/pm8001/pm80xx_hwi.c:	if (-1 == check_fw_ready(pm8001_ha)) {
drivers/scsi/scsi_debug.c:	if (-1 == res)
drivers/scsi/scsi_debug.c:	if (-1 == ret) {
drivers/staging/fbtft/fb_agm1264k-fl.c:			if (-1 == coeff) {
fs/btrfs/check-integrity.c:		if (-1 == sf->i) {
fs/btrfs/check-integrity.c:		if (-1 == sf->i) {
fs/btrfs/check-integrity.c:		} else if (-1 == btrfsic_check_all_ref_blocks(state,
fs/isofs/util.c:		if (-52 <= tz && tz <= 52)
lib/test_bpf.c:		"JMP_JSLT_K: Signed jump: if (-2 < -1) return 1",
lib/test_bpf.c:		"JMP_JSLT_K: Signed jump: if (-1 < -1) return 0",
lib/test_bpf.c:		"JMP_JSGT_K: Signed jump: if (-1 > -2) return 1",
lib/test_bpf.c:		"JMP_JSGT_K: Signed jump: if (-1 > -1) return 0",
lib/test_bpf.c:		"JMP_JSLE_K: Signed jump: if (-2 <= -1) return 1",
lib/test_bpf.c:		"JMP_JSLE_K: Signed jump: if (-1 <= -1) return 1",
lib/test_bpf.c:		"JMP_JSGE_K: Signed jump: if (-1 >= -2) return 1",
lib/test_bpf.c:		"JMP_JSGE_K: Signed jump: if (-1 >= -1) return 1",
lib/test_bpf.c:		"JMP_JGT_K: Unsigned jump: if (-1 > 1) return 1",
lib/test_bpf.c:		"JMP_JSGT_X: Signed jump: if (-1 > -2) return 1",
lib/test_bpf.c:		"JMP_JSGT_X: Signed jump: if (-1 > -1) return 0",
lib/test_bpf.c:		"JMP_JSLT_X: Signed jump: if (-2 < -1) return 1",
lib/test_bpf.c:		"JMP_JSLT_X: Signed jump: if (-1 < -1) return 0",
lib/test_bpf.c:		"JMP_JSGE_X: Signed jump: if (-1 >= -2) return 1",
lib/test_bpf.c:		"JMP_JSGE_X: Signed jump: if (-1 >= -1) return 1",
lib/test_bpf.c:		"JMP_JSLE_X: Signed jump: if (-2 <= -1) return 1",
lib/test_bpf.c:		"JMP_JSLE_X: Signed jump: if (-1 <= -1) return 1",
lib/test_bpf.c:		"JMP_JGT_X: Unsigned jump: if (-1 > 1) return 1",
sound/pci/rme9652/hdspm.c:	if (-1 == val)
sound/usb/usx2y/usbusx2y.c:		if (-2 == us428ctls->CtlSnapShotLast) {
tools/testing/selftests/net/mptcp/mptcp_connect.c:		if (-1 == setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &one,

