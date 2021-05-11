Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2B637A718
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhEKMw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhEKMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:52:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FE5C061574;
        Tue, 11 May 2021 05:51:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bf4so22717150edb.11;
        Tue, 11 May 2021 05:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AtlaChiKHJEoOrKhQo7KFd2i26uZ7qyixOAMRudY7ag=;
        b=Rs3Xr67xM8FhKJF6nPdbMkrlJZiS+flW87rJoRFam+4Epnv9yUgySyERAeK3GzVf2P
         PkkX4e5Ah5ULA3CHlyuHB8AUkDN8TLSfm80iJ9DoUPRqyfChSPjevr2vtxm5bZfpDJQ/
         I9hZruacfWYcOzLR842+hp/1ev3/Gv0QBSFwgn1aQxNK2fyBQPC07XQvRbOWAWZoQENJ
         +LEk9L3N+Hv+ThxbAueClbIetRg9k365CoYN5A1WNOOIoU5xIgB4Ds7VWA8vt2Y3maqL
         gGxGZQEMs6UMbQLCm/swslmyn+UgsxW3JBqJrF5ht0bjDVd5OWnzHqQVMtyCtQAzSW5E
         FAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AtlaChiKHJEoOrKhQo7KFd2i26uZ7qyixOAMRudY7ag=;
        b=ZdT5jRyvsXMOlksisvIYG9XAPd89+vdJFWEEChhjjtVDXeIXPiCChef2d7WRcfdTX6
         /08UjRqbl6YxqQSNs0Qm/79iCE/lAfSn8v4mqAJIsic7MC82sUC1Z6TjF75htxqK/hoI
         AaGWaaAiSNfSCCjvqD4ZTtaoyqL9w+kIWcyVV+YMjS7p4tpscKClwqkDl3Sc0P1EVTHr
         7LOTsn3MEoT77uown0CO8Wlp0gVQu/5J525WZX4BC9CmRAWtioAr6sgr+yRGc2DImL8W
         VAsaxFpPjbi49pWzhJPNi0Cb18NUBKoru6e82es5uW0OL0PKxnGUCpcRk9+b/1w0zDr+
         SeAw==
X-Gm-Message-State: AOAM533Ug9WPEGLjl2AIq2+CqoUw58zruDYUasEZdwcTFVtaEcTYAQE1
        q1XbDAT8HstP7HyracCIMWc=
X-Google-Smtp-Source: ABdhPJxmkMsD5BKrElZ9N4qDlnA73IhqexGvpcmn7p0r0X/GA6Xml2AGMUkv0Sp0/pL3FYeEu/mk2A==
X-Received: by 2002:aa7:cc98:: with SMTP id p24mr11102230edt.353.1620737478235;
        Tue, 11 May 2021 05:51:18 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.gmail.com with ESMTPSA id r16sm14607820edq.87.2021.05.11.05.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 05:51:17 -0700 (PDT)
Date:   Tue, 11 May 2021 14:51:15 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm: Enlarge IO_SPACE_LIMIT needed for some SoC
Message-ID: <YJp9w7FqxO6+SVT6@Ansuel-xps.localdomain>
References: <20210511021656.17719-1-ansuelsmth@gmail.com>
 <YJnq3Y3/I1kdV1Ov@casper.infradead.org>
 <YJnswvYFUjlNS7Fa@Ansuel-xps.localdomain>
 <CAMj1kXGLihr4gq3iwHy6mLKG4UHWnh5XAgxZDZmnmNPErfJ-bg@mail.gmail.com>
 <YJp1WYTXHsSAA0ES@Ansuel-xps.localdomain>
 <CAMj1kXHoc283aHT2EjxyRe8_cTWn_SUGoVLNKJ+40ia8Fppynw@mail.gmail.com>
 <YJp6mbJRMlN5yFC7@Ansuel-xps.localdomain>
 <CAMj1kXFDY0Go9yDXAfAiN8pm-q0qGSYaWNw0LVw044ErZ0zKvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFDY0Go9yDXAfAiN8pm-q0qGSYaWNw0LVw044ErZ0zKvQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 02:46:49PM +0200, Ard Biesheuvel wrote:
> On Tue, 11 May 2021 at 14:37, Ansuel Smith <ansuelsmth@gmail.com> wrote:
> >
> > On Tue, May 11, 2021 at 02:30:36PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 11 May 2021 at 14:15, Ansuel Smith <ansuelsmth@gmail.com> wrote:
> > > >
> > > > On Tue, May 11, 2021 at 06:26:28AM +0200, Ard Biesheuvel wrote:
> > > > > On Tue, 11 May 2021 at 04:32, Ansuel Smith <ansuelsmth@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, May 11, 2021 at 03:24:29AM +0100, Matthew Wilcox wrote:
> > > > > > > On Tue, May 11, 2021 at 04:16:54AM +0200, Ansuel Smith wrote:
> > > > > > > > Ipq8064 SoC requires larger IO_SPACE_LIMIT on second and third pci port.
> > > > > > >
> > > > > > > Do you really?  I mean, yes, theoretically, I understand it, the
> > > > > > > hardware supports 64kB of I/O port space per root port.  But I/O
> > > > > > > port space is rather deprecated these days.  My laptop has precisely
> > > > > > > two devices with I/O ports, one with 64 bytes and the other with 32
> > > > > > > bytes.  Would you really suffer by allocating 16kB of I/O port
> > > > > > > space to each root port?
> > > > > >
> > > > > > We were talking about this in the other wrong patch. I also think this
> > > > > > much space looks wrong. The current ipq806x dts have this space so it's
> > > > > > actually broken from a long time. The only reason pci worked before was
> > > > > > because the pci driver didn't actually check if the settings were right.
> > > > > > New kernel introduced more checks and this problem showed up. (to be
> > > > > > more precise, the pci port are commonly used by the ath10k wifi and the
> > > > > > second ath10k wifi fails to init because of this problem)
> > > > > > If you can give me any hint on how to check if the space can be reduced
> > > > > > I would be very happy to investigate it.
> > > > > > In the driver I notice that the max buffer is set to 2k, could be this a
> > > > > > hint?
> > > > > >
> > > > >
> > > > > Could you share the output of lspci -vv from such a system?
> > > > >
> > > > > I agree with Matthew that fiddling with the size of the I/O space
> > > > > range probably papers over another problem, and with the odd
> > > > > exception, no PCIe card used on ARM systems actually uses their I/O
> > > > > BARs, even when they have them. (I used to carry a PCIe serial port
> > > > > card to UEFI plugfests because that was the only thing that would stop
> > > > > working if a system configured its I/O resource window incorrectly)
> > > >
> > > > Here is the output of lspci -vv
> > > >
> > > > 0000:00:00.0 PCI bridge: Qualcomm Device 0101 (prog-if 00 [Normal decode])
> > > >         Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
> > > >         I/O behind bridge: [disabled]
> > > >         Memory behind bridge: 08000000-081fffff [size=2M]
> > > >         Prefetchable memory behind bridge: [disabled]
> > >
> > > So this a MMIO window to the endpoint
> > >
> > > ...
> > >
> > > >
> > > > 0000:01:00.0 Network controller: Qualcomm Atheros QCA9984 802.11ac Wave 2 Wireless Network Adapter
> > > >         Region 0: Memory at 08000000 (64-bit, non-prefetchable) [size=2M]
> > >
> > > ... and the endpoint has a single *MMIO* BAR of size 2 MiB.
> > >
> > > This has *nothing* to do with port I/O, which is what you are
> > > modifying with your patch.
> > >
> > > Did you check that the problem exists without the patch, and that the
> > > patch makes it go away?
> > >
> > >
> >
> > Yes without the change to IO_SPACE_LIMIT, the ath10k driver fails to
> > init as it can't access the reg. Only the first pci wifi works but the
> > second one fails to init. By increasing the limit all comes back to
> > normal. What I really can't understand is if the big IO space set in the
> > ipq8064 dtsi was wrong from the start and the ath10k fails to init just
> > because is missconfigured. Any idea how to find the appropriate max IO space
> > for the pci?
> >
> 
> OK, so the entire second host bridge fails to probe, because there is
> no virtual address space left for the I/O window.
> 
> Just change the 'downstream I/O' window size in the DT to 64k
> (0x10000) - I assume the current size (0x100000) is a typo anyway.

Ok, so my fear were right... someone just typo the IO when the dtsi was
pushed and was wrong from all that times. Much easier and cleaner
solution. 

