Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B1231CA99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 13:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhBPMgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 07:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhBPMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 07:36:46 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ED3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=yZklHLs0tcaPiBVtjbyqkY53qsYK8J21/behTZDq/8I=; b=rkFs35BVdTJexzqxGiLyvdzUP3
        wAypE7Fztvm3+Fm2B31VWQvSU3xZH7elMJhx2FPezdwh1e4wNXWFh52L3Vo3IVc886vbSI249asVQ
        xwVmOR9KzHzRu+Uz8bV1y1jZ2gQtBxOGOpnsoPVZACy+67Di2TH4dfyQ+bIrrTDRG19I7dl2MGDhK
        RIIWIDH3S0VdFCJfVHzUyOkmlptNHXcj7nv5p4EQ55lIDg8FGO8RCjI0+2zfd0cJhRT/Mh7LnccBP
        xTCe1CDuHDJC5ngtDgeb8K+WUDY6IttIaj5QyMi3o3Pkdy1/hpt386lxQC0IRF5Nzc+8giYJ/rms/
        ohnU6yaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBza6-0002nP-5D; Tue, 16 Feb 2021 12:35:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 946103007CD;
        Tue, 16 Feb 2021 13:35:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F1FB2058CB0E; Tue, 16 Feb 2021 13:35:52 +0100 (CET)
Date:   Tue, 16 Feb 2021 13:35:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Borislav Petkov <bp@alien8.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, it+linux-x86@molgen.mpg.de,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: smpboot: CPU numbers printed as warning
Message-ID: <YCu8KIM2kt6mb1Ol@hirez.programming.kicks-ass.net>
References: <e964b2ae-7a15-a510-e76a-56d704949d62@molgen.mpg.de>
 <YCuVEDXyIu+yE4c1@alley>
 <20210216101449.GA10592@zn.tnic>
 <60b342c3-23ab-12f7-8e04-4fa0bcd3c508@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60b342c3-23ab-12f7-8e04-4fa0bcd3c508@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:58:19PM +0100, Paul Menzel wrote:
> Dear Borislav, dear Petr,
> 
> 
> Am 16.02.21 um 11:14 schrieb Borislav Petkov:
> > On Tue, Feb 16, 2021 at 10:49:04AM +0100, Petr Mladek wrote:
> > > Also you should add '\n' into the previous string to make the behavior
> > > clear. It will always be printed on a new line when pr_info()
> > > is used.
> > 
> > This was made to use pr_cont() on purpose so that the output is compact,
> > for example:
> > 
> > [    4.088605] x86: Booting SMP configuration:
> > [    4.089511] .... node  #0, CPUs:          #1   #2   #3   #4   #5   #6   #7   #8   #9  #10  #11  #12  #13  #14  #15  #16  #17  #18  #19  #20  #21  #22  #23  #24  #25  #26  #27  #28  #29  #30  #31  #32  #33  #34  #35  #36  #37  #38  #39  #40  #41  #42  #43  #44  #45  #46  #47  #48  #49  #50  #51  #52  #53  #54  #55  #56  #57  #58  #59  #60  #61  #62  #63
> > [    4.188510] .... node  #1, CPUs:    #64  #65  #66  #67  #68  #69  #70  #71  #72  #73  #74  #75  #76  #77  #78  #79  #80  #81  #82  #83  #84  #85  #86  #87  #88  #89  #90  #91  #92  #93  #94  #95  #96  #97  #98  #99 #100 #101 #102 #103 #104 #105 #106 #107 #108 #109 #110 #111 #112 #113 #114 #115 #116 #117 #118 #119 #120 #121 #122 #123 #124 #125 #126 #127
> > [    4.307511] .... node  #0, CPUs:   #128 #129 #130 #131 #132 #133 #134 #135 #136 #137 #138 #139 #140 #141 #142 #143 #144 #145 #146 #147 #148 #149 #150 #151 #152 #153 #154 #155 #156 #157 #158 #159 #160 #161 #162 #163 #164 #165 #166 #167 #168 #169 #170 #171 #172 #173 #174 #175 #176 #177 #178 #179 #180 #181 #182 #183 #184 #185 #186 #187 #188 #189 #190 #191
> > [    4.416511] .... node  #1, CPUs:   #192 #193 #194 #195 #196 #197 #198 #199 #200 #201 #202 #203 #204 #205 #206 #207 #208 #209 #210 #211 #212 #213 #214 #215 #216 #217 #218 #219 #220 #221 #222 #223 #224 #225 #226 #227 #228 #229 #230 #231 #232 #233 #234 #235 #236 #237 #238 #239 #240 #241 #242 #243 #244 #245 #246 #247 #248 #249 #250 #251 #252 #253 #254 #255
> > [    4.531683] smp: Brought up 2 nodes, 256 CPUs
> > [    4.534510] smpboot: Max logical packages: 2
> > [    4.535527] smpboot: Total of 256 processors activated (1147449.34 BogoMIPS)
> 
> Yes, the intention is clear, but it’s not working perfectly in all
> situations. Any ideas, how to improve that? After reading John’s response,
> I’d go with `pr_cont(KERN_INFO "message part");`.
> 
> By the way, what are these CPU numbers useful for? Isn’t
> 
>     smp: Brought up 2 nodes, 256 CPUs
> 
> enough information, and nothing else needed for the majority of users?

Majority yes, the primary use case is knowing which CPU is failing to
come up. Hardly ever happens, but when it does, its bloody annoying to
not know :-)

Also, the majority of people only has a hand full of CPUs, so they don't
care either way.
