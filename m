Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3924839AC26
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 22:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFCU7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 16:59:40 -0400
Received: from mail.efficios.com ([167.114.26.124]:53446 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhFCU7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 16:59:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D246B31F06F;
        Thu,  3 Jun 2021 16:57:53 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NAhXqpSvLK0Q; Thu,  3 Jun 2021 16:57:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 40D7B31F447;
        Thu,  3 Jun 2021 16:57:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 40D7B31F447
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1622753873;
        bh=YaPGgTAtjE+jspV8TrcYK7HBAIzOUt4Oip6vpWG66w8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=rDlcQEwRsRzzCJbtG9UwCtSn62kOPuERIE1zZm7AlP76ch1YABigHMxrplSzCUTeD
         VtgwK808ejBrN0K320M3ILms4y3aUBhGEiHwQAYq0dLxZOK/hoNDX5DifuWdF1iQLe
         AbJ2eIRtdiqNGT0BQzt/bAcTyPS5kOiQx5K8rq0C7dSwg3fotbtkn2vBxkBzL1tl92
         fXHazpBQXKmMmVigw4QdmN5KeJNUmy6gXaIBtr50eeL0uClGkt7z03f3k1JUt+U2SQ
         8EonPFAWcHyfIcXD6vX5lGPxY2uEvQcqjT/jmrUnYxf63j6cHE71ZnyTHjUOfgC7rE
         Ylt3RSS+9s3Jw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id slnI4CuQ0G_G; Thu,  3 Jun 2021 16:57:53 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 3168231EFFB;
        Thu,  3 Jun 2021 16:57:53 -0400 (EDT)
Date:   Thu, 3 Jun 2021 16:57:53 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org,
        rp@svcs.cs.pdx.edu
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <293749719.7760.1622753873071.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] Userspace RCU 0.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4026)
Thread-Index: sEBXQE/MhfBlDpmhebxv28mTBCxeXg==
Thread-Topic: Userspace RCU 0.13.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Userspace RCU 0.13 release is mostly a library soname version bump
to address an ABI incompatibility between the 0.10 and { 0.11, 0.12 }
releases.

The observed application vs library compatibility problem occurs as follows:

- An application executable is built with _LGPL_SOURCE defined, includes
  any of the Userspace RCU 0.10 urcu flavor headers, and is built
  without the -fpic compiler option.

- The Userspace RCU 0.10 library shared objects are updated to 0.11
  or 0.12 without rebuilding the application.

- The application will hang, typically when RCU grace period
  (synchronize_rcu) is invoked.

Some possible work-arounds for this are:

- Rebuild the application against Userspace RCU 0.11+,
- Rebuild the application with -fpic.
- Upgrade Userspace RCU to 0.13+ without installing 0.11 nor 0.12.


* Explanation of the issue

In URCU 0.11, we introduced new symbols to clean up the library symbol
namespacing, using the "alias" attribute to keep emitting the old
symbols, expecting to preserve ABI backward compatibility.
Unfortunately, it turns out that even though it works well for function
symbols, it is broken for public global variables due to the way ELF
copy relocation works.

When building a non-PIC executable that uses an extern variable, a .bss
symbol is emitted in the executable. This will take precedence over the
symbol implemented within the library in the Global Symbol Table.
Unfortunately, the alias within the library will not be aware that the
actual GST symbol differs from its alias within the library, and the
addresses for the symbol and its alias will differ at runtime.

Considering that this compatibility issue affects official library
releases, there is little we can do beyond documenting this issue, and
bumping the Userspace RCU major soname for the next (0.13) release.

In summary, do not upgrade from Userspace RCU 0.10 to 0.11 or 0.12 if 
you have applications which:

- define _LGPL_SOURCE
- use Userspace RCU 0.10 headers
- are not compiled with -fpic

We recommend instead to upgrade to Userspace RCU 0.13, which bumps the
library soname major number.

Thanks,

Mathieu

Project website: http://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
