Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940A1407B67
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 05:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhILDnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 23:43:45 -0400
Received: from mail-1.ca.inter.net ([208.85.220.69]:37263 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbhILDno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 23:43:44 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Sep 2021 23:43:44 EDT
Received: from mp-mx11.ca.inter.net (mp-mx11.ca.inter.net [208.85.217.19])
        by mail-1.ca.inter.net (Postfix) with ESMTP id 27BBB2EA0BD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 23:36:01 -0400 (EDT)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by mp-mx11.ca.inter.net (mp-mx11.ca.inter.net [208.85.217.19]) (amavisd-new, port 10024)
        with ESMTP id IU6-e5sSaosa for <linux-kernel@vger.kernel.org>;
        Sat, 11 Sep 2021 23:36:00 -0400 (EDT)
Received: from [192.168.48.23] (host-45-78-207-107.dyn.295.ca [45.78.207.107])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id C6E802EA01E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 23:36:00 -0400 (EDT)
Reply-To: dgilbert@interlog.com
To:     LKML <linux-kernel@vger.kernel.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
Subject: how many memset(,0,) calls in kernel ?
Message-ID: <1c4a94df-fc2f-1bb2-8bce-2d71f9f1f5df@interlog.com>
Date:   Sat, 11 Sep 2021 23:36:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a pretty rough estimate:
$ find . -name '*.c' -exec fgrep "memset(" {} \; > memset_in_kern.txt

$ cat memset_in_kern.txt | wc -l
     20159

Some of those are in comments, EXPORTs, etc, but the vast majority are
in code. Plus there will be memset()s in header files not counted by
that find. Checking in that output file I see:

$ grep ", 0," memset_in_kern.txt | wc -l
     18107
$ grep ", 0" memset_in_kern.txt | wc -l
     19349
$ grep ", 0x" memset_in_kern.txt | wc -l
     1210
$ grep ", 0x01" memset_in_kern.txt | wc -l
     3
$ grep ", 0x0," memset_in_kern.txt | wc -l
     199
$ grep ",0," memset_in_kern.txt | wc -l
     72

$ grep "= memset" memset_in_kern.txt | wc -l
      11

It seems only 11 invocations use the return value of memset() .

If the BSD flavours of Unix had not given us:
    void bzero(void *s, size_t n);
would the Linux kernel have something similar in common usage (e.g.
memzero() or mem0() ), that was less wasteful than the standard:
    void *memset(void *s, int c, size_t n);
in the extremely common case where c=0 and the return value is
not used?

Doug Gilbert


