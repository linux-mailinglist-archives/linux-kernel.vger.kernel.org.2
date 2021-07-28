Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF03D978D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 23:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhG1Va7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 17:30:59 -0400
Received: from smtprelay0175.hostedemail.com ([216.40.44.175]:43824 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230156AbhG1Va6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 17:30:58 -0400
Received: from omf03.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B560E180D0797;
        Wed, 28 Jul 2021 21:30:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 640A113D99;
        Wed, 28 Jul 2021 21:30:55 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 28 Jul 2021 14:30:54 -0700
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Subject: Re: patch suggestion: Kconfig symbols
In-Reply-To: <09db53b9-7edf-44fc-c6b7-7c4e9198a2d4@infradead.org>
References: <295b8f8c-4264-9f32-6723-9d2d574021ac@infradead.org>
 <e77e2329bdafdbea538be0d7edb8a9d7d3e45990.camel@perches.com>
 <09db53b9-7edf-44fc-c6b7-7c4e9198a2d4@infradead.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <733d2747b67a8a172333b51bacbf77fe@perches.com>
X-Sender: joe@perches.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.79
X-Stat-Signature: 1rkzgomx86n88r4rw5msropwwmhpsboi
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 640A113D99
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/hNJ9eNNNyc+Lzlm6mkIzHlx1pO20mbns=
X-HE-Tag: 1627507855-712796
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-28 12:41, Randy Dunlap wrote:
> On 7/28/21 8:37 AM, Joe Perches wrote:
>> On Mon, 2021-07-26 at 17:21 -0700, Randy Dunlap wrote:
>>> Running scripts/checkkconfigsymbols.py reports several hundred (maybe 
>>> thousand)
>>> Kconfig symbols that are used questionably. Lots of these are false 
>>> positives
>>> but lots of the remainder could use some cleaning up.
>> []
>>> False positive example:
>>> 
>>> XCHOFFLD_MEM
>>> Referencing files: drivers/scsi/qla2xxx/qla_mbx.c
>>> Similar symbols: OF_PMEM, CXL_MEM, CXL_PMEM
>>> 
>>> The Referencing source file does this:
>>> #define CONFIG_XCHOFFLD_MEM	0x3
>>> 
>>> which is legitimate, so no change is needed.
>> 
>> Legitimate is perhaps dubious.
>> 
>> It might be better if Kconfig has exclusive use of CONFIG_<foo> naming 
>> so
>> renaming all the other existing CONFIG_<foo> defines might be 
>> appropriate.
> 
> I would prefer that as well -- maybe 15 years ago.
> But I think it's too invasive to make that change now.

I do not think it's that invasive.

It's something that doesn't have to be done immediately either.

It's not too many macro defines and not too many uses of those defines.
