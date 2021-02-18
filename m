Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888D631F093
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhBRT4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:56:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230353AbhBRTgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613676918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b0idBDK6G4n5u+jujeub1WfEZumTKDrABDdLtoiU3do=;
        b=G1kbJhoesCH2Llt4nPIfflWfTFewUgMAWZ/55g3SNMgaWNweaOTjF7ttbxmdpp/7i1BXx8
        2qIW9xbiNldnTa+2LEvNVWnGSCBGhc7Lx0ObNn3RkZ+BAN869bCsYyTmaIsLxSuWgncOsP
        PtksPlX7SfTTXR/IHKYif9vKEYB1WBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-VgZPue6QPJiMvqR56o2v6A-1; Thu, 18 Feb 2021 14:35:14 -0500
X-MC-Unique: VgZPue6QPJiMvqR56o2v6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57DC4107ACE4;
        Thu, 18 Feb 2021 19:35:12 +0000 (UTC)
Received: from treble (ovpn-117-118.rdu2.redhat.com [10.10.117.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C5226E407;
        Thu, 18 Feb 2021 19:35:10 +0000 (UTC)
Date:   Thu, 18 Feb 2021 13:35:08 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        live-patching@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: 'perf probe' and symbols from .text.<something>
Message-ID: <20210218193508.mw6ugmh6bjlplbwe@treble>
References: <09257fb8-3ded-07b0-b3cc-55d5431698d8@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09257fb8-3ded-07b0-b3cc-55d5431698d8@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 08:09:17PM +0300, Evgenii Shatokhin wrote:
> Is there a way to allow probing of functions in .text.<something> ?
> 
> Of course, one could place probes using absolute addresses of the functions
> but that would be less convenient.
> 
> This also affects many livepatch modules where the kernel code can be
> compiled with -ffunction-sections and each function may end up in a separate
> section .text.<function_name>. 'perf probe' cannot be used there, except
> with the absolute addresses.
> 
> Moreover, if FGKASLR patches are merged (https://lwn.net/Articles/832434/)
> and the kernel is built with FGKASLR enabled, -ffunction-sections will be
> used too. 'perf probe' will be unable to see the kernel functions then.

A hack fix like the below would probably work, but as you pointed out,
FGKASLR is going to be a problem.  I suspect the proper fix is for perf
to learn how to deal with multiple executable ELF sections.

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 69b9b71a6a47..0c522a87f6ce 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -4,6 +4,10 @@
  * combine them automatically.
  */
 SECTIONS {
+	.text : {
+		*(.text)
+		*(.text.*)
+	}
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)

