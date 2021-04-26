Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B536BA3D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 21:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241638AbhDZTrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 15:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbhDZTrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:47:32 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CBCC061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:46:50 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lb7Bv-000N5V-PL; Mon, 26 Apr 2021 21:46:47 +0200
Message-ID: <2cafd6d0c6378b36644d04fe263a53a866354574.camel@sipsolutions.net>
Subject: Re: [BISECTED] 5.12 hangs at reboot
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Harald Arnesen <harald@skogtun.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 26 Apr 2021 21:46:47 +0200
In-Reply-To: <CAHk-=wjvVMucgoAQKfi-x=jvYgKW1_LRmvnAfk3JGMkOSg9CQQ@mail.gmail.com> (sfid-20210426_214533_066559_1ED0DAEC)
References: <09464e67-f3de-ac09-28a3-e27b7914ee7d@skogtun.org>
         <CAHk-=wgA1Ma6e5qZO1EP9oMveLPJFbj=SC1R0ZewCmC-u0_r=A@mail.gmail.com>
         <34d778fa-343f-912f-2fd7-a8ba49bd1b95@skogtun.org>
         <54debab9a79df628cff86a637dde13c281001578.camel@sipsolutions.net>
         <CAHk-=wjvVMucgoAQKfi-x=jvYgKW1_LRmvnAfk3JGMkOSg9CQQ@mail.gmail.com>
         (sfid-20210426_214533_066559_1ED0DAEC)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-04-26 at 12:45 -0700, Linus Torvalds wrote:
> On Mon, Apr 26, 2021 at 12:38 PM Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > 
> > > 
> > > dmesg from 5.12 without the revert is attached.
> > 
> > That's it? There it just hangs? Not even printing something about tasks
> > getting stuck?
> 
> I assume the dmesg is from before trying to shut the system down.

Ahrg. I misread the subject as "boot" rather than "reboot".

Right. Maybe if it's modules, could try to remove them rather than
reboot?

johannes

