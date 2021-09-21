Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D380F413510
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhIUOMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:12:45 -0400
Received: from pv50p00im-ztbu10011701.me.com ([17.58.6.53]:46094 "EHLO
        pv50p00im-ztbu10011701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231781AbhIUOMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1632233475; bh=SjcvMyiL+bTjpjyeXzGNGSMMrG9Q9hXIatEKEB7TpAU=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=NvX0hfW+Gn44qWq+Wo7coiLFtkJGdIVDUBdD+/Hu/890+VXzjG0QaEWV5t0NGixha
         4VWVEOdcc8ybBTOl6cG5L1W5Mf5Mo27lNqQs6NXG351DzwEI9e6oJQpsVrvZUQjPaw
         W1e4G02R1p1GjGpMnfJ9PWXgZwPnCA517iujNJZDVN8blOgKQqKEP9OgLHCxwC3hK5
         VQnVOeQwNmG4UpGUpvp0HGaZ7FRdlwa3KuzuuU838rmxb4u1RqR3Uw2id7kMr9icjA
         n0macdZriuICmIECZgMriwQuvhejnGoTKY32TcB6ZcG5blQi3zxZ17uSeeM4AQUS39
         VgQUALCQiasAg==
Received: from 192.168.1.7 (unknown [120.245.3.37])
        by pv50p00im-ztbu10011701.me.com (Postfix) with ESMTPSA id 071E38A02FD;
        Tue, 21 Sep 2021 14:11:04 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/2] Use generic code for virtual address of randomization
 of x86
From:   Xiongwei Song <sxwjean@me.com>
In-Reply-To: <4EB3D825-264D-447A-8C55-FA0CE8BC31F6@chromium.org>
Date:   Tue, 21 Sep 2021 22:11:01 +0800
Cc:     x86@kernel.org, linux-mm@kvack.org,
        Xiongwei Song <sxwjean@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Balbir Singh <sblbir@amazon.com>, Jens Axboe <axboe@kernel.dk>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Kim Phillips <kim.phillips@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Stefan Metzmacher <metze@samba.org>,
        Marco Elver <elver@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A30C4D61-59CC-4F30-B2F5-692BBE6DB3FF@me.com>
References: <20210921110252.2593542-1-sxwjean@me.com>
 <4EB3D825-264D-447A-8C55-FA0CE8BC31F6@chromium.org>
To:     Kees Cook <keescook@chromium.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-21_04:2021-09-20,2021-09-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=522 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2109210088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 21, 2021, at 9:24 PM, Kees Cook <keescook@chromium.org> wrote:
> 
> 
> 
> On September 21, 2021 4:02:50 AM PDT, sxwjean@me.com wrote:
>> From: Xiongwei Song <sxwjean@gmail.com>
>> 
>> Hello,
>> 
>> The two patches are to use generic code for randomization of virtual
>> address of x86. Since the basic code logic of x86 is same as generic
>> code, so no need to implement these functions on x86, please see the
>> details in comments of patch 2.
> 
> Hi!
> 
> The other patches do not seem to have arrived; I only see 0/2.

Sorry for that. Let me resend the patches.

Regards,
Xiongwei

