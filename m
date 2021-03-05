Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A532F401
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCETgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:36:24 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:50414 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhCETgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:36:12 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 125Ja5Qd031095;
        Fri, 5 Mar 2021 20:36:05 +0100
Date:   Fri, 5 Mar 2021 20:36:05 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Justin Mitchell <jmitchell@aes-corp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: NAND Flash Issue Need Help!
Message-ID: <20210305193605.GB31072@1wt.eu>
Reply-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <MN2PR04MB5615A581CF6938C780531C7F95969@MN2PR04MB5615.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR04MB5615A581CF6938C780531C7F95969@MN2PR04MB5615.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Mar 05, 2021 at 06:38:08PM +0000, Justin Mitchell wrote:
> Issue:
> Intermittent occurrence of failure to program new boards from CM.

No idea what "CM" is here, but that's not relevant here anyway.

> Primary partition mounted OK
> Loading file 'dtb/at91sam9g25ek.dtb' to addr 0x21000000 with size 25836 (0x000064ec)...
> Done
> DTB file loaded OK
> Loading file 'kernel/uImage' to addr 0x22000000 with size 2968536 (0x002d4bd8)...
> UBIFS error (pid 0): ubifs_read_node: bad node type (255 but expected 1) UBIFS error (pid 0): ubifs_read_node: bad node at LEB 215:0 UBIFS error (pid 0): do_readpage: cannot read page 178 of inode 1244, error -22 Error reading file 'kernel/uImage'
> kernel/uImage not found!

But this is not a Linux issue if its U-boot which is failing to load the
kernel. Are you sure you didn't upgrade u-boot at the same time as your
kernel ?

> If I will do ubifscat kernel/uImage it starts to read the file and then I see this error:
> 
> P?@ ???P?@ ???P?@ ??Q?? ?
(...)
> -- System haltedAttempting division by 0!stack-protector: Kernel stack is corrupted Uncompressing Linux...decompressor returned an error done, booting the kernel.
(...)

That's not an error :-)  It's the contents of the bootstrap code in the
kernel that deals with very early issues such as decompression failures.
You're just dumping your kernel image to the screen here.

(...)
> ubifsmount <volume-name>
>     - mount 'volume-name' volume
> 
> And if I will do the same second time then it starts but getting no uImage error:
> 
> DTB file loaded OK
> Loading file 'kernel/uImage' to addr 0x22000000 with size 2968536 (0x002d4bd8)...
> UBIFS error (pid 0): ubifs_read_node: bad node type (255 but expected 1) UBIFS error (pid 0): ubifs_read_node: bad node at LEB 215:0 UBIFS error (pid 0): do_readpage: cannot read page 178 of inode 1244, error -22 Error reading file 'kernel/uImage'
> kernel/uImage not found!
> 
> Strange that I need to run same command twice and that uImage also can not be loaded from SystemB

So indeed that has nothing to do with Linux. Maybe your image is much larger
than the previous one and a bug in the u-boot code used to load the image
makes it randomly fail.
 
Hoping this helps,
Willy
