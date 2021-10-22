Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0663443792D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 16:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhJVOr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 10:47:28 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42889 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232825AbhJVOrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 10:47:23 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 513645C0131;
        Fri, 22 Oct 2021 10:45:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 22 Oct 2021 10:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:mime-version:content-type; s=
        fm2; bh=Et6KZrcdZK6bzUf+xuIArNSukxz0R3kbny373GbNlNg=; b=JEPRB9mT
        n2jxyb4o8h14YZe96Pc7sG05S6rQCjcXXlDyJjlDwUAwEY9sepj4baQxEuekafkp
        Phss/z4QADcy5HzS2i17j1BI+BDHtQZxkFeCmOoPaG8lCWC7qWICdXlZmJtlgsZE
        qwsEhjch6mX4yqrBkydAA3ZKZcJttD9Il+vXPyQ4ADaORfPH0/kzoSevRjGKnb8g
        O19+UgXvfeOuxvDyp7cu2Gq1cT4NXObdN8KsTvZPaqyCgvcnjCZBW0k3zX91RwIf
        YzX6D+TsyJJOl07AAI5WRYDzkryloFkuSr/Mg3GuVFHS4KYEtytgFjOqSPqGjpKL
        +SKFSZoaaUT3lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=Et6KZrcdZK6bzUf+xuIArNSukxz0R
        3kbny373GbNlNg=; b=eD7CcMuklBlx+0I6iKhsogonHNAOCe7uBXkGPS50OTThe
        +qcXSVNsYRL+EZybQG8P1iNZEXtVUpdVIhA587rm5O5i1XIuin25JJLI+D36IHgM
        0mQCeaFo8qAdYjkD5zk6KQYZJ7cHPsiPt3sq23SBfGq9jM10OxEqgRtQbmLrIakP
        BoADzpvrPe//Llt054HJPIY6gbKuBV5EneFn53TLVMfPzdeFAWDvVDG+MrH9mWEM
        0zzEbnfEuAs1vUj2V9gA58oN3tkCd7HtqvvdZWBtF2vUnQfd10AQjHBSuS3r04Ay
        3LoWlsqMssnAIQFEPbHPjE+fjuA4+KvMDghaxjqmg==
X-ME-Sender: <xms:cc5yYRU5E7jt86x2Im1xX3ISDGjVfyynSVPoXSYHqqKPdyV9EqThTA>
    <xme:cc5yYRlIysKdxpC3yUsvsN8W7CJxqpqqquMnDAjvzKmnQy0FAUymDuHWV2DctBTuQ
    lYnjnQOrr4idA>
X-ME-Received: <xmr:cc5yYdaAU8l-AMXyIhMYJnCmxma7S4jV0H04zNrH05znKLWLEEp3bw1024Sd5pMWraN5E2pDfSqZc2aqNiIsQZ6hfxqBotiu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvkedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesthdtredttd
    dtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecu
    ggftrfgrthhtvghrnhepvedugeeuffelgeekhfehtdefhfekffdtgedvteeitddvieduhf
    ekheekueehleelnecuffhomhgrihhnpehkrhhorghhrdgtohhmpdhgihhthhhusgdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrh
    gvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:cc5yYUWLeVyJWtPet9rsuFU7jgi7Q_13pPBakQ61vftDnT3FBVgGWw>
    <xmx:cc5yYbkOwAie3fm2ARr7gEcF1thxq6ZZyP-2kzops0NkwCKagq1K5g>
    <xmx:cc5yYRcXc8jObN4DvafxtLX3f7NLzA_yAuVd4lor2d0gI8DJLf2qSw>
    <xmx:cc5yYQzabi7DGdVgFy_a758VsDTlyFSXFvsLMf_9LaPMmS7TrDGfGA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Oct 2021 10:45:04 -0400 (EDT)
Date:   Fri, 22 Oct 2021 16:44:53 +0200
From:   Greg KH <greg@kroah.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: usbview 2.1 release
Message-ID: <YXLOZSarSq5zPiUT@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 9 years, I figure it's about time for a new release of usbview, as
some people still use it, and there's been some grumbling about a
release by the distro packages that have to deal with it.

Nothing big in here, just loads of build configuration changes in order
to keep the thing building properly within most modern Linux systems,
and a few other small changes.  Full changelog is at the bottom of this
email.

Ideally in the future, this will move into the usbutils package, when I
get some free time, and remove it from the need to access the debugfs
file and take advantage of the extended device structure parsing that
'lsusb' provides.

The package can be downladed at:
	http://www.kroah.com/linux/usb/usbview-2.1.tar.gz
and the git tree can be found at:
	http://github.com/gregkh/usbview

thanks,

greg k-h

-------
version 2.1
        - build warnings fixed
        - increased max number of interfaces allowed, fixing problem with some
          USB sound devices.
        - autogen.sh added
        - LICENSES directory added and license moved to it
        - SPDX license headers added
        - policykit support added
        - usbview.desktop: Add desktop file.
        - usbview_icon.svg: Convert xpm bitmap icon into a scalable svg icon.
        - configure.in configure.ac: Rename former to latter.
        - autgen.sh, config.h.in: Remove in favour of "autoreconf --install".
        - configure.ac, Makefile.am:
          - Autotools tweaks and normalization.
          - Don't include CPPFLAGS in AM_CPPFLAGS.
          - Remove references to unset GLIB_CFLAGS and GLIB_LIBS in Makefile.am
          - Reorder clauses to usual order.
          - Remove obsolete comments.
          - Add m4 quoting to configure.ac per autoconf documentation.
          - VERSION belongs in config.h from configure.ac, not Makefile.am.
          - Use AX_CFLAGS_WARN_ALL instead of custom code.
          - Address "autoupdate" and "autoreconf --warn=all" output.
          - Support (conditional) installation of icons, including bitmap
            icons at various resolutions, and desktop file.
          - remove NEWS, now unnecessary due to automake foreign option.
        - Makefile.am, interface.c: Generate icon compiled into executable from scalable icon.
        - .gitignore: Updates.
        - ChangeLog: trim whitespace
        - squelch compiler warning: examine fgets return value

