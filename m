Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA914413672
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhIUPsd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Sep 2021 11:48:33 -0400
Received: from foo.stuge.se ([212.116.89.98]:43270 "EHLO foo.stuge.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234182AbhIUPsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:48:32 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Sep 2021 11:48:31 EDT
Received: (qmail 19290 invoked by uid 1000); 21 Sep 2021 15:40:21 -0000
Message-ID: <20210921154021.19289.qmail@stuge.se>
Date:   Tue, 21 Sep 2021 15:40:20 +0000
From:   Peter Stuge <peter@stuge.se>
To:     Alec Brown <alec.r.brown@oracle.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     "coreboot@coreboot.org" <coreboot@coreboot.org>,
        "grub-devel@gnu.org" <grub-devel@gnu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "systemd-devel@lists.freedesktop.org" 
        <systemd-devel@lists.freedesktop.org>,
        "trenchboot-devel@googlegroups.com" 
        <trenchboot-devel@googlegroups.com>,
        "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Aleksandr Burmashev <alexander.burmashev@oracle.com>,
        "allen.cryptic@gmail.com" <allen.cryptic@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "btrotter@gmail.com" <btrotter@gmail.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        "dpsmith@apertussolutions.com" <dpsmith@apertussolutions.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "hun@n-dimensional.de" <hun@n-dimensional.de>,
        "james.dutton@gmail.com" <james.dutton@gmail.com>,
        "javierm@redhat.com" <javierm@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        "jwerner@chromium.org" <jwerner@chromium.org>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "krystian.hebel@3mdeb.com" <krystian.hebel@3mdeb.com>,
        "leif@nuviainc.co m" <leif@nuviainc.com>,
        "lukasz.hawrylko@intel.com" <lukasz.hawrylko@intel.com>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "michal.zygowski@3mdeb.com" <michal.zygowski@3mdeb.com>,
        "mjg59@google.com" <mjg59@google.com>,
        "mtottenh@akamai.com" <mtottenh@akamai.com>,
        "phcoder@gmail.com" <phcoder@gmail.com>,
        "piotr.krol@3mdeb.com" <piotr.krol@3mdeb.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        "sjg@chromium.org" <sjg@chromium.org>,
        "trini@konsulko.com" <trini@konsulko.com>,
        "tyhicks@linux.microsoft.com" <tyhicks@linux.microsoft.com>,
        "ulrich.windl@rz.uni-regensburg.de" 
        <ulrich.windl@rz.uni-regensburg.de>,
        "wvervoorn@eltan.com" <wvervoorn@eltan.com>,
        "rharwood@redhat.com" <rharwood@redhat.com>
Subject: Re: [SPECIFICATION RFC v3] The firmware and bootloader log
 specification
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <A7F710D3-5148-4E92-9E3D-5D850AD0245F@gmx.de>
 <DM6PR10MB2986A960E859A744FDC3875ABCDE9@DM6PR10MB2986.namprd10.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alec Brown wrote:
> Below is how the layout of these logs would store their data.
> 
> bf_log_header:
>                +-------------------+
> u32            | version           |
> u32            | size              |
> u8[64]         | producer          |
> u8[64]         | log_format        |
> u64            | flags             |
> u64            | next_bflh_addr    |
> u64            | log_addr          |
> u32            | log_size          |
>                +-------------------+

I suggest to include a .magic at least in bf_log_header and an
.xor_checksum or .crc32 only in bf_log_header.

.magic doubles as endianess indicator when the structures are
stored on movable media. (Pick an asymmetric magic bit pattern!)

I suggest renaming .next_bflh_addr to .next_log_header and .log_addr
to .log_buffer_addr.

I suggest to remove .size and .log_size:

The rationale for .size is "to allow for backward compatibility" but
that seems redundant thanks to .version.

.log_size can be calculated from the subordinate data and is thus
mostly an unneccessary source of potential inconsistency.


> bf_log_buffer:
>                +-------------------+
> u32            | version           |
> u32            | size              |
> u8[64]         | producer          |
> u32            | next_msg_off      |
> bf_log_msg[l]  | msgs              |
>                +-------------------+

I suggest replacing .size and .next_msg_off with .messages containing l:

.size can then be calculated from .messages; again, reliably avoiding
inconsistency between .size and .next_msg_off.

Allocated size doesn't seem useful if writers must anyway maintain state
containing the starting address. If writers must be allowed to be completely
stateless then maybe at least rename .size to .allocated_size and see below
for discovery.

Having .messages also eliminates the need for an end-of-messages marker
when the allocated space is not yet filled.


> bf_log_msg:
>                +-------------------+
> u32            | size              |
> u64            | ts_nsec           |
> u32            | level             |
> u32            | facility          |
> u32            | msg_off           |
> u8[n]          | type              |
> u8[m]          | msg               |
>                +-------------------+

It seems inconsistent that log_header.size and log_msg.size cover only
the respective struct itself while log_buffer.size also covers all
subordinate messages. Skipping all .size in this version fixes that.

And log_msg.size is not very useful since both .type and .msg have variable
length; it's not possible to access .msg without scanning .type. Please at
a minimum add .type_size but better yet replace .size with .type_size and
.msg_size.


> There is still the outstanding issue of how the logs will be sent to the OS. If
> UEFI is used, we can use config tables. If ACPI or Device Tree is used, we can
> use bf_log_header.next_bflh_addr to present the logs. If none of these platforms
> are used, it becomes a lot trickier to solve this issue.
> 
> Any suggestions are much appreciated and will be taken into consideration.

Having bf_log_header.magic and some bf_log_header.$checksum, a strict rule
for bf_log_header start address granularity and a strict maximum offset
for the first header from top and/or bottom of memory allows to quickly
discover a log in memory without explicit handover.


> LPC System Boot and Security Micro-conference on the 22nd of September
> at 7:50 AM PDT (14:50 UTC).

Have fun! :)


Heinrich Schuchardt wrote:
> We already the EFI_TCG2_PROTOCOL and RFC 5424 (The syslog protocol).
> Why do we need to start from scratch?

That's a good question. I guess noone wants to settle for a standard
from somewhere else. ;)

I wouldn't mind if log_msg was a syslog transport, but I can understand
if that's rejected because syslog messages require a lot of parsing for
presentation while Alec's proposal seems focused on efficiency and simplicity.

It's also nice to be able to strictly mandate UTF-8 for all fields.
(RFC 5424 allows MSG to be anything.)


Kind regards

//Peter
