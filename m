Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D882934371E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 04:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCVDGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 23:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229696AbhCVDFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616382333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H18Krr3VPi3XrnC8v8eoUvklLwifS/IayqlYwzdzwmk=;
        b=Wffk2OhatSXSvBuuakl/hpaHkgyGDQFGZyVeNrIiqqyFnkRg+TXISKMWf9hCYocMgRk8W4
        ryGeLysVt04UPnDUGxVRGYZ+ANKYmjwgtnj3eAxdqmEo4dkBW4afDTnZYuwJoMAXxWFNkK
        PYMtFNK4MSxIGVLF4keGdysP1if38Gw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-uO0VZ59yMkqKCM5KHrENaQ-1; Sun, 21 Mar 2021 23:05:25 -0400
X-MC-Unique: uO0VZ59yMkqKCM5KHrENaQ-1
Received: by mail-pj1-f72.google.com with SMTP id co15so26057794pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 20:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H18Krr3VPi3XrnC8v8eoUvklLwifS/IayqlYwzdzwmk=;
        b=iqBgRl/AbfOzH9JWXBJBMoyKT2B1MwqrnpP2lx0kClyQSrGQLxY92XfnRFyQzzCGnb
         2LOkDmKJAp05xIrhGXklqD7whceYotmmvUoihxulAxoZFsR4S6t+BqWjpYAc7EVpXp1B
         I3pjcfdvtr+pARFxgYebEiOfpD5nIX2CuHSde1iIvauFG+Wf53LdNwJ/TIu3hidYYit8
         HKIiaJDrgj3Olz+iw7nlkXxyq/keywPMEmm9xaR4Yk9Qn40iYtLLfEymQUxFxfOlHSPV
         9i0P+K4OtTsve5oIkK7flgxQ0rMwGw4YWyxOxx8+pVon4rb+MtyluILsFLdjLv68UIX3
         bG7Q==
X-Gm-Message-State: AOAM532OZyer8+A4KgsinCw2TxeCX7IQThwK8HAzmSzy/G0q4poLlZH2
        cPiDzAjxS0bSwVvBVEFDvE16+Zz7FrmYhVTzlg25frDp/7tME5R2t56AweuPLsCUY4NA+UlY1sN
        R4UgjnWd2F5VMuURYALDyuAXA
X-Received: by 2002:a63:181c:: with SMTP id y28mr20697452pgl.175.1616382324707;
        Sun, 21 Mar 2021 20:05:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLB6nUelZG5bkxlZC/d+7zAwvMJEUb0ZmhwiHWMk4RN2AZheqJT7FUr403d9oYlXR980YnuA==
X-Received: by 2002:a63:181c:: with SMTP id y28mr20697438pgl.175.1616382324457;
        Sun, 21 Mar 2021 20:05:24 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l19sm11694616pjt.16.2021.03.21.20.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 20:05:24 -0700 (PDT)
Date:   Mon, 22 Mar 2021 11:05:13 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] ext4 fixes for v5.12
Message-ID: <20210322030513.GA1925732@xiangao.remote.csb>
References: <YFeQ9eBFn5JELyYo@mit.edu>
 <CAHk-=wjahvxdYmEgZEOqSSOVdTP-Njqbh6e8=PDVtt4Md7qHNg@mail.gmail.com>
 <ca33cb6a-9be9-1a2c-efa3-1dc5996897f6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca33cb6a-9be9-1a2c-efa3-1dc5996897f6@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 09:33:54AM +0800, zhangyi (F) wrote:
> On 2021/3/22 6:23, Linus Torvalds wrote:
> > On Sun, Mar 21, 2021 at 11:31 AM Theodore Ts'o <tytso@mit.edu> wrote:
> >>
> >> zhangyi (F) (3):
> >>       ext4: find old entry again if failed to rename whiteout
> >>       ext4: do not iput inode under running transaction in ext4_rename()
> >>       ext4: do not try to set xattr into ea_inode if value is empty
> > 
> > Side note: this is obviously entirely up to the author, but I think it
> > would be nice if we would encourage people to use their native names
> > if/when they want to.
> > 
> > Maybe this "zhangyi (F)" is how they _want_ to write their name in the
> > kernel, and that's obviously fine if so.
> > 
> > But at the same time, coming from Finland, I remember how people who
> > had the "odd" characters (Ã¥Ã¤Ã¶) in their name ended up replacing them
> > with the US-ASCII version (generally "aa" "ae" and "oe"), and it
> > always just looked bad to a native speaker. Particularly annoying in
> > public contexts.
> > 
> > At the same time, for the same reason, I can also understand people
> > not wanting to even expose those characters at all, because then
> > non-native speakers invariably messed it up even worse...
> > 
> > Anyway, I think and hope that we have the infrastructure to do it
> > right not just for Latin1, but the more complex non-Western character
> > sets too.
> > 
> > And as a result should possibly encourage people to use their native
> > names if they want to. At least make people aware that it _should_
> > work.
> > 
> > Again, maybe I'm barking up the wrong tree, and in this case "zhangyi
> > (F) <yi.zhang@huawei.com>" is just what zhangyi prefers simply because
> > it's easier/more convenient.
> > 
> > But I just wanted to mention it, because we _do_ have examples of it
> > working. Not many, but some:
> > 
> >     git log --pretty="%an" --since=2.years | sort -u | tail
> > 
> > including examples of having the Westernized name in parenthesis for
> > the "use that one if you can't do the real one" case..
> > 
> Hi, Linus.
> 
> I will use my real name "Yi Zhang" next time.

er.. Try to comment my thoughts about this a bit... just random noise.

I think the legel name would be "Zhang Yi" (family name goes first [1])
according to
The Chinese phonetic alphabet spelling rules for Chinese names [2].

Indeed, that is also what the legel name is written in alphabet on our
passport or credit/debit cards.

Also, many official English-written materials use it in that way, for
example, a somewhat famous bastetball player Yao Ming [3][4][5].

That is what I wrote my own name as this but I also noticed the western
ordering of names is quite common for Chinese people in Linux kernel.
Anyway, it's just my preliminary personal thought (might be just my
own perference) according to (I think, maybe) formal occasions.

[1] https://en.wikipedia.org/wiki/Wikipedia:Naming_conventions_(Chinese)
[2] http://www.moe.gov.cn/ewebeditor/uploadfile/2015/01/13/20150113091249368.pdf
[3] https://en.wikipedia.org/wiki/Yao_Ming
[4] https://www.nbcsports.com/edge/basketball/nba/player/28778/yao-ming
[5] https://news.cgtn.com/news/2020-09-26/Spotlight-Ex-NBA-star-Yao-Ming-05-02-2018-U36mm3dYas/index.html

Thanks,
Gao Xiang

> 
> Thanks,
> Yi.

