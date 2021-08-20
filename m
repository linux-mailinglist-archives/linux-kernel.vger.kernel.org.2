Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC833F329D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbhHTR7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:59:17 -0400
Received: from smtprelay0067.hostedemail.com ([216.40.44.67]:60882 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235713AbhHTR7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:59:15 -0400
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8C4981804EE3A;
        Fri, 20 Aug 2021 17:58:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id A29152EBFA4;
        Fri, 20 Aug 2021 17:58:35 +0000 (UTC)
Message-ID: <51685e024c86a691aaf7c94ad74f04971e736d3e.camel@perches.com>
Subject: BPF MAINTAINERS entry "K: bpf" casts too wide a net
From:   Joe Perches <joe@perches.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 20 Aug 2021 10:58:34 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: A29152EBFA4
X-Stat-Signature: 3cimuwdoh68ae1q3gbc1ibx5uxjzssud
X-Spam-Status: No, score=0.10
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/l2u7Um2HH+RyIjt7rz8+orLZYkJvFF/A=
X-HE-Tag: 1629482315-825942
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAINTAINERS entry for BPF (Safe dynamic programs and tools)
includes K: bpf

This entry seems to match far too many files in the kernel sources.

$ git grep --name-only 'bpf' | wc -l
1398

Likely this entry should be removed or improved to ignore unnecessary
matches within files like scripts/checkpatch.pl

Perhaps instead this could be something like:

K:	\bbpf_|_bpf\b




