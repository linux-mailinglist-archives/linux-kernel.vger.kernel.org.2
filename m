Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3623222C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 00:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhBVXs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 18:48:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52774 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhBVXsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 18:48:17 -0500
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=mussarela)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1lEKvL-0000qH-TA; Mon, 22 Feb 2021 23:47:32 +0000
Date:   Mon, 22 Feb 2021 20:47:26 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Jim Lin <jilin@nvidia.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: configfs: Fix KASAN use-after-free
Message-ID: <20210222234726.GA166848@mussarela>
References: <1484647168-30135-1-git-send-email-jilin@nvidia.com>
 <878tqakmiy.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878tqakmiy.fsf@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2017 at 12:29:09PM +0200, Felipe Balbi wrote:
> 
> Hi,
> 
> Jim Lin <jilin@nvidia.com> writes:
> > When gadget is disconnected, running sequence is like this.
> > . composite_disconnect
> > . Call trace:
> >   usb_string_copy+0xd0/0x128
> >   gadget_config_name_configuration_store+0x4
> >   gadget_config_name_attr_store+0x40/0x50
> >   configfs_write_file+0x198/0x1f4
> >   vfs_write+0x100/0x220
> >   SyS_write+0x58/0xa8
> > . configfs_composite_unbind
> > . configfs_composite_bind
> >
> > In configfs_composite_bind, it has
> > "cn->strings.s = cn->configuration;"
> >
> > When usb_string_copy is invoked. it would
> > allocate memory, copy input string, release previous pointed memory space,
> > and use new allocated memory.
> >
> > When gadget is connected, host sends down request to get information.
> > Call trace:
> >   usb_gadget_get_string+0xec/0x168
> >   lookup_string+0x64/0x98
> >   composite_setup+0xa34/0x1ee8
> >
> > If gadget is disconnected and connected quickly, in the failed case,
> > cn->configuration memory has been released by usb_string_copy kfree but
> > configfs_composite_bind hasn't been run in time to assign new allocated
> > "cn->configuration" pointer to "cn->strings.s".
> >
> > When "strlen(s->s) of usb_gadget_get_string is being executed, the dangling
> > memory is accessed, "BUG: KASAN: use-after-free" error occurs.
> >
> > Signed-off-by: Jim Lin <jilin@nvidia.com>
> > ---
> > Changes in v2:
> > Changes in v3:
> >  Change commit description
> 
> well, I need to be sure you tested this with Linus' tree. The reason I'm
> asking is because this could be a bug caused by Android changes. From
> your previous patch, the problem started with android_setup().
> 
> Please test with v4.10-rc4 and any configfs-based gadget.
> 
> -- 
> balbi

I tested this with dummy_hcd on top of a 5.8 kernel and I got lsusb to respond
with an error instead of the right manufacturer string, after overwriting such
a string after binding.

With the patch applied, after the string is overwritten, lsusb will show the
updated string.

Because of commit 81c7462883b0cc0a4eeef0687f80ad5b5baee5f6 ("USB: replace
hardcode maximum usb string length by definition"), the patch will need a
fixup. Should I send a v2 with my sign-off?

Thanks.
Cascardo.
