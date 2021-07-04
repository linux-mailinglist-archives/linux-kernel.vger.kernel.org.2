Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C442D3BAD40
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 15:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhGDOBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 10:01:22 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:65120 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhGDOBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 10:01:21 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Jul 2021 10:01:21 EDT
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id CCC5B403CB;
        Sun,  4 Jul 2021 15:53:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1625406786; x=1627221187; bh=8uVUSMPNAeWl5eb58VReYcTTAmLLAbd7tmA
        CfUIIQmo=; b=UOQWxpjrGTFlVsjja0+x3lb0nQnhgSZQbXR2ke9xvMdqO5H1VQY
        qF6/uLh9On/d/Xa2JLLFRRSQ+WMXxkH7IFdoaM+ojuFwM7Yk8X2D61dBZVNyZQTm
        fk00rIJqxBl7lSLo7S/2HO4UCKcKfc2OePUcQ+OAtjpA4TxUX8sAq/RvtZSzh/F+
        ea3xAaonxRtD6Bt+dMylSbtY8GTtYFMNNlN8g2oB39mi3uOScjJ392iLcXtd8C9v
        8QrvOsiipHmmtXraB5KB54aFjsbTe/zSEiSp9beBiYmcC1iSWRa2Ke4MIXFlU5Mi
        3WBdNr/AdahqmOEnYBGhl7EMWbPxLYxIxyVZxPjm2je1oigPfVuXN40Nzfobt/eV
        hS9iaEi+G+nw2BTR/EoDPiJX9G8BNnenKkmNhSJx72LoN4YDXIEFgg33jOnfkta5
        XJ/4W/4aLqVZAiZEjZps4w0M1LymfgmTD8rPhaZIJceu4ZKDxYzsgEaserAtQx53
        X6fgUjNSIo3O4d3XOY8Ap8+y98OMKK3O44Hn/KaaqOXnGFzGFoExufKOVa339Aa9
        PNQTfc2F4Mk10BGwvpMYiap5oByYi0aTnRQALRPF8u+ozu6IOdZgOAXJgjgyTI7J
        8h6bK3ikp5qvQKYjZq0Z3i50bTWwWs9Lq/JQrbo3SPaNNu5TRvmW3Huc=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id amjP_pqs2F4a; Sun,  4 Jul 2021 15:53:06 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 040CD41869;
        Sun,  4 Jul 2021 15:52:52 +0200 (CEST)
Received: from int-subm001.mykolab.com (unknown [10.9.37.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 736454BEB;
        Sun,  4 Jul 2021 15:52:43 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 04 Jul 2021 15:52:41 +0200
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Lepton Wu <ytht.net@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Kitt <steve@sk2.org>, Wang Qing <wangqing@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] docs: accounting: update delay-accounting.rst
 reference
In-Reply-To: <20210603095632.35ab9fee@coco.lan>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
 <629b0bd21d02c8faef9a6d17d9eee8ff612715e0.1622648507.git.mchehab+huawei@kernel.org>
 <YLe0BQcrnfRgH1dV@hirez.programming.kicks-ass.net>
 <20210602200121.64a828a1@coco.lan> <871r9k6rmy.fsf@meer.lwn.net>
 <20210602221940.7e0a6135@coco.lan> <20210603095632.35ab9fee@coco.lan>
Message-ID: <2566fa8cfbfc89aed22d7a8d20e303a4@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

and sorry for the late reply

On 2021-06-03 09:56, Mauro Carvalho Chehab wrote:
> Some manual work is needed, as a couple of replacements occurred inside
> tables. I also need to check if automarkup.py got everything, including
> the ones inside tables.
> 
> I'm in doubt with regards to translations. There, the tag is used
> to point to the original translation, like on
> Documentation/translations/it_IT/core-api/symbol-namespaces.rst:
> 
> 	:Original: :doc:`../../../core-api/symbol-namespaces`
> 	:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
> 
> My personal preference would be to keep using it for translations.

Why is this your preference? I would prefer to have a consistent style 
everywhere.
If ":doc:" is now discouraged, then do not use it. What am I missing?

-- 
Federico Vaga
