Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1163F34E617
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhC3LH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:07:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:24221 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231782AbhC3LHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:07:39 -0400
IronPort-SDR: Y4q5PucNHa4KO8Rhe8vgWNb00TIie/ZHWcXAZNsHFEFnqv2PorEN+6iyCVXW5k7g1o7uT3fp0q
 ewbupBiucXzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="276913592"
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="276913592"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 04:07:39 -0700
IronPort-SDR: jQ93ivM6KOkmcumcWsJCaL/OZGz82ahTE/rCNKH/jjLZqV5PdkvvUCLbEvNVRAf133XhHlz80s
 POtWoU3Cer7w==
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="418126879"
Received: from ograu-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.175])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 04:07:20 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel-doc: better handle '::' sequences
In-Reply-To: <CANiq72=kRzBQsjgUeuVNXRmRVN8zXzMvMn+yTWt=YhR+r2wNEg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210325184615.08526aed@coco.lan> <2cf44cf1fa42588632735d4fbc8e84304bdc235f.1616696051.git.mchehab+huawei@kernel.org> <87tuozyslu.fsf@meer.lwn.net> <20210325191435.GZ1719932@casper.infradead.org> <87a6qrx7wf.fsf@meer.lwn.net> <20210325221437.GA1719932@casper.infradead.org> <CANiq72=kRzBQsjgUeuVNXRmRVN8zXzMvMn+yTWt=YhR+r2wNEg@mail.gmail.com>
Date:   Tue, 30 Mar 2021 14:07:14 +0300
Message-ID: <87wntooq71.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> On Thu, Mar 25, 2021 at 11:18 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> The rust code is alredy coming though ...
>>
>> rust/kernel/buffer.rs:/// A pre-allocated buffer that implements [`core::fmt::Write`].
>>
>> so now we have three formats.  Markdown and RST are _very_ similar, but
>> not identical [1].  Oh, and even better we now have three distinct tools --
>> kerneldoc, rustdoc and sphinx.  Have the rust people reached out to you
>> about integrating the various docs?
>
> Yeah, I reached out to Jonathan a few weeks ago to discuss how we will
> approach this, because I knew using `rustdoc` and Markdown could be
> contentious ;-)
>
> This is the solution we decided to go for the RFC but, of course,
> nothing is set in stone:
>
>   1. The "out-of-line" docs in `Documentation/rust/`: these will be in
> RST as usual [*]. However, please note this does not include APIs or
> anything like that, as it is done in the C side. Only a few "general
> documents" that don't fit anywhere else are kept here.
>
>   2. The "inline" docs in Rust source files: these will be parsed by
> `rustdoc` and written in Markdown. These will contain the majority of
> the Rust documentation. `rustdoc` is designed for Rust code, and
> internally uses the Rust compiler, which comes with a number of
> advantages.
>
> The generated HTML docs will be showcased in the RFC. It is my hope
> that this way we get feedback on them and see if people agree this
> approach is worth keeping. We have put an effort (and I have been
> annoying contributors enough to that end :-) to provide high-quality
> documentation from the get-go.
>
> Please note that we chose this way knowing well that inconsistency and
> adding "yet one more tool" needs to come with big advantages to
> offset. We think it is the best approach nevertheless!
>
> [*] I discussed with Jonathan using Markdown since Sphinx supports it.
> The main advantage would be easier refactoring of comments between the
> out- and inline docs. But this is very minor, thus mixing two formats
> inside `Documentation/` does not seem like worth it.

FWIW, and this should be obvious, I think going with what's natural for
documenting Rust source code is the right choice. Markdown as parsed by
rustdoc. People will expect Rust documentation comments to just work,
without some kernel specific gotchas. Don't try to reinvent the wheel
here, it's a dead end.

The interesting question is, I think, figuring out if rustdoc output
could be incorporated into Sphinx documentation, and how. It would be
pretty disappointing if we ended up with two documentation silos based
on the module implementation language.

At the moment it seems to me rustdoc can only output HTML, and that
seems pretty deeply ingrained in the tool. AFAICT, there isn't an
intermediate phase where it would be trivial to output the documentation
in Markdown (though I don't really know Rust and I only had a cursory
look at librustdoc). And even if it were possible, with Markdown you'd
have the issues with conflicting Markdown flavours, what's supported by
rustdoc vs. commonmark.py used by Sphinx.

Perhaps the bare minimum is running rustdoc first, and generating the
results into Sphinx static pages [1], to make them part of the
whole. Even if the HTML style might be different. Perhaps it would be
possible to come up with a Sphinx extensions to make it convenient to
reference content in the rustdoc generated HTML from reStructuredText.


BR,
Jani.


[1] https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-html_static_path


-- 
Jani Nikula, Intel Open Source Graphics Center
