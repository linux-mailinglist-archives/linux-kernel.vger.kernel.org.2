Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10464383090
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 16:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbhEQO2b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 May 2021 10:28:31 -0400
Received: from elephants.elehost.com ([216.66.27.132]:36071 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239464AbhEQOYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:24:13 -0400
X-Greylist: delayed 967 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 May 2021 10:24:12 EDT
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14HE6i14052495
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 May 2021 10:06:45 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
Subject: [Broken] RE: [ANNOUNCE] Git v2.32.0-rc0
Date:   Mon, 17 May 2021 10:06:38 -0400
Message-ID: <007201d74b25$de5f2710$9b1d7530$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AddLJVIzUwm4TVJaQsaMsWz47AhTyg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 17, 2021 3:06 AM, Junio C Hamano wrote:
>To: git@vger.kernel.org
>Cc: Linux Kernel <linux-kernel@vger.kernel.org>; git-
>packagers@googlegroups.com
>Subject: [ANNOUNCE] Git v2.32.0-rc0
>
>An early preview release Git v2.32.0-rc0 is now available for
>testing at the usual places.  It is comprised of 545 non-merge
>commits since v2.31.0, contributed by 76 people, 29 of which are
>new faces [*].

Git 2.23.0 no longer builds on NonStop x86. Reference to pthreads is not permitted in s non-pthread build.

**** ERROR **** [1210]:
   libgit.a(ipc-unix-socket.o): In function `thread_block_sigpipe':
   ipc-unix-socket.o(.text+0xb87): unresolved reference to pthread_sigmask.

We are not building with pthreads. This is net-new for 2.32.0-rc0, not seen in 2.31.0.

I'm unsure as to why this file is even being included in a non-thread build.

Randall


