Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFD435ADB6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbhDJNhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234392AbhDJNhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:37:14 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 536846108B;
        Sat, 10 Apr 2021 13:36:56 +0000 (UTC)
Date:   Sat, 10 Apr 2021 09:36:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-trace-devel@vger.kernel.org" 
        <linux-trace-devel@vger.kernel.org>,
        Linux-trace Users <linux-trace-users@vger.kernel.org>
Cc:     Zamir SUN <sztsian@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, zsun@redhat.com,
        Vitaly Chikunov <vt@altlinux.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Yordan Karadzhov <ykaradzhov@vmware.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tony Jones <tonyj@suse.de>, John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Al Stone <ahs3@debian.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jes Sorensen <jes.sorensen@gmail.com>
Subject: [ANNOUNCE] libtraceevent 1.2.0
Message-ID: <20210410093653.0d9ffc95@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm pleased to announce the new version of libtraceevent library has been
released:

  libtraceevent: 1.2.0


 https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/snapshot/libtraceevent-1.2.0.tar.gz
 https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/


Changes since 1.1.3:

 - Generic override warning() function is now called tep_warning()

 - Generic override __vwarning() is now called tep_vwarning() and takes another
   parameter that can pass in the application name that calls it.

 - New API tep_parse_kallsyms() to load kallsyms file.

 - New API tep_parse_saved_cmdlines() to load saved_cmdilnes file.

 - New API tep_parse_printk_formats() to load printk_formats file.

 - And small clean ups and fixes.

-- Steve
