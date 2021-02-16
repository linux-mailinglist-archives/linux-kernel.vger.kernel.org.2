Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164D731C891
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 11:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhBPKPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 05:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhBPKPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:15:35 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D09FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 02:14:54 -0800 (PST)
Received: from zn.tnic (p200300ec2f07cd00f44a1614bcf30b76.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:cd00:f44a:1614:bcf3:b76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E859E1EC0258;
        Tue, 16 Feb 2021 11:14:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1613470492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=es3LFLvxwQwnM8ydZJRSDZPVUDOU5ITzF+k336lrkA0=;
        b=MUmecksBcDHYP8tve6oDClB6f9EqQQnDHqTHLL6oc2Elr1x8U3qaQkNrW66leTi+EPxmpr
        EelyK69jHLa7hrBJ6Y0ACxuN6jYQoTXOzf8yo9DQrWzILGGgvxtprsRP/4jD83EUNTIphy
        WFA0VZxk838fc4iVis2+X4kWpDAZVXE=
Date:   Tue, 16 Feb 2021 11:14:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, it+linux-x86@molgen.mpg.de,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: smpboot: CPU numbers printed as warning
Message-ID: <20210216101449.GA10592@zn.tnic>
References: <e964b2ae-7a15-a510-e76a-56d704949d62@molgen.mpg.de>
 <YCuVEDXyIu+yE4c1@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCuVEDXyIu+yE4c1@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 10:49:04AM +0100, Petr Mladek wrote:
> Also you should add '\n' into the previous string to make the behavior
> clear. It will always be printed on a new line when pr_info()
> is used.

This was made to use pr_cont() on purpose so that the output is compact,
for example:

[    4.088605] x86: Booting SMP configuration:
[    4.089511] .... node  #0, CPUs:          #1   #2   #3   #4   #5   #6   #7   #8   #9  #10  #11  #12  #13  #14  #15  #16  #17  #18  #19  #20  #21  #22  #23  #24  #25  #26  #27  #28  #29  #30  #31  #32  #33  #34  #35  #36  #37  #38  #39  #40  #41  #42  #43  #44  #45  #46  #47  #48  #49  #50  #51  #52  #53  #54  #55  #56  #57  #58  #59  #60  #61  #62  #63
[    4.188510] .... node  #1, CPUs:    #64  #65  #66  #67  #68  #69  #70  #71  #72  #73  #74  #75  #76  #77  #78  #79  #80  #81  #82  #83  #84  #85  #86  #87  #88  #89  #90  #91  #92  #93  #94  #95  #96  #97  #98  #99 #100 #101 #102 #103 #104 #105 #106 #107 #108 #109 #110 #111 #112 #113 #114 #115 #116 #117 #118 #119 #120 #121 #122 #123 #124 #125 #126 #127
[    4.307511] .... node  #0, CPUs:   #128 #129 #130 #131 #132 #133 #134 #135 #136 #137 #138 #139 #140 #141 #142 #143 #144 #145 #146 #147 #148 #149 #150 #151 #152 #153 #154 #155 #156 #157 #158 #159 #160 #161 #162 #163 #164 #165 #166 #167 #168 #169 #170 #171 #172 #173 #174 #175 #176 #177 #178 #179 #180 #181 #182 #183 #184 #185 #186 #187 #188 #189 #190 #191
[    4.416511] .... node  #1, CPUs:   #192 #193 #194 #195 #196 #197 #198 #199 #200 #201 #202 #203 #204 #205 #206 #207 #208 #209 #210 #211 #212 #213 #214 #215 #216 #217 #218 #219 #220 #221 #222 #223 #224 #225 #226 #227 #228 #229 #230 #231 #232 #233 #234 #235 #236 #237 #238 #239 #240 #241 #242 #243 #244 #245 #246 #247 #248 #249 #250 #251 #252 #253 #254 #255
[    4.531683] smp: Brought up 2 nodes, 256 CPUs
[    4.534510] smpboot: Max logical packages: 2
[    4.535527] smpboot: Total of 256 processors activated (1147449.34 BogoMIPS)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
