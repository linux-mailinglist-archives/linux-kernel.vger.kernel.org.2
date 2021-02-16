Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D40F31CA4D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 13:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhBPL7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:59:48 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:45689 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230360AbhBPL7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:59:05 -0500
Received: from [192.168.0.6] (ip5f5aea7e.dynamic.kabel-deutschland.de [95.90.234.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 31C4020647925;
        Tue, 16 Feb 2021 12:58:20 +0100 (CET)
Subject: Re: smpboot: CPU numbers printed as warning
To:     Borislav Petkov <bp@alien8.de>, Petr Mladek <pmladek@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, it+linux-x86@molgen.mpg.de,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>
References: <e964b2ae-7a15-a510-e76a-56d704949d62@molgen.mpg.de>
 <YCuVEDXyIu+yE4c1@alley> <20210216101449.GA10592@zn.tnic>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <60b342c3-23ab-12f7-8e04-4fa0bcd3c508@molgen.mpg.de>
Date:   Tue, 16 Feb 2021 12:58:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210216101449.GA10592@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Borislav, dear Petr,


Am 16.02.21 um 11:14 schrieb Borislav Petkov:
> On Tue, Feb 16, 2021 at 10:49:04AM +0100, Petr Mladek wrote:
>> Also you should add '\n' into the previous string to make the behavior
>> clear. It will always be printed on a new line when pr_info()
>> is used.
> 
> This was made to use pr_cont() on purpose so that the output is compact,
> for example:
> 
> [    4.088605] x86: Booting SMP configuration:
> [    4.089511] .... node  #0, CPUs:          #1   #2   #3   #4   #5   #6   #7   #8   #9  #10  #11  #12  #13  #14  #15  #16  #17  #18  #19  #20  #21  #22  #23  #24  #25  #26  #27  #28  #29  #30  #31  #32  #33  #34  #35  #36  #37  #38  #39  #40  #41  #42  #43  #44  #45  #46  #47  #48  #49  #50  #51  #52  #53  #54  #55  #56  #57  #58  #59  #60  #61  #62  #63
> [    4.188510] .... node  #1, CPUs:    #64  #65  #66  #67  #68  #69  #70  #71  #72  #73  #74  #75  #76  #77  #78  #79  #80  #81  #82  #83  #84  #85  #86  #87  #88  #89  #90  #91  #92  #93  #94  #95  #96  #97  #98  #99 #100 #101 #102 #103 #104 #105 #106 #107 #108 #109 #110 #111 #112 #113 #114 #115 #116 #117 #118 #119 #120 #121 #122 #123 #124 #125 #126 #127
> [    4.307511] .... node  #0, CPUs:   #128 #129 #130 #131 #132 #133 #134 #135 #136 #137 #138 #139 #140 #141 #142 #143 #144 #145 #146 #147 #148 #149 #150 #151 #152 #153 #154 #155 #156 #157 #158 #159 #160 #161 #162 #163 #164 #165 #166 #167 #168 #169 #170 #171 #172 #173 #174 #175 #176 #177 #178 #179 #180 #181 #182 #183 #184 #185 #186 #187 #188 #189 #190 #191
> [    4.416511] .... node  #1, CPUs:   #192 #193 #194 #195 #196 #197 #198 #199 #200 #201 #202 #203 #204 #205 #206 #207 #208 #209 #210 #211 #212 #213 #214 #215 #216 #217 #218 #219 #220 #221 #222 #223 #224 #225 #226 #227 #228 #229 #230 #231 #232 #233 #234 #235 #236 #237 #238 #239 #240 #241 #242 #243 #244 #245 #246 #247 #248 #249 #250 #251 #252 #253 #254 #255
> [    4.531683] smp: Brought up 2 nodes, 256 CPUs
> [    4.534510] smpboot: Max logical packages: 2
> [    4.535527] smpboot: Total of 256 processors activated (1147449.34 BogoMIPS)

Yes, the intention is clear, but it’s not working perfectly in all 
situations. Any ideas, how to improve that? After reading John’s 
response, I’d go with `pr_cont(KERN_INFO "message part");`.

By the way, what are these CPU numbers useful for? Isn’t

     smp: Brought up 2 nodes, 256 CPUs

enough information, and nothing else needed for the majority of users?


Kind regards,

Paul
