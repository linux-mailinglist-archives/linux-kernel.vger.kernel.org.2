Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E490E34E7B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhC3MoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:44:19 -0400
Received: from smtp2-2.goneo.de ([85.220.129.34]:52076 "EHLO smtp2-2.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhC3Mnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:43:51 -0400
Received: from [192.168.1.127] (unknown [85.16.47.255])
        by smtp2.goneo.de (Postfix) with ESMTPSA id B700C203843D;
        Tue, 30 Mar 2021 14:43:45 +0200 (CEST)
Subject: Re: [PATCH] kernel-doc: better handle '::' sequences
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
References: <20210325184615.08526aed@coco.lan>
 <2cf44cf1fa42588632735d4fbc8e84304bdc235f.1616696051.git.mchehab+huawei@kernel.org>
 <87tuozyslu.fsf@meer.lwn.net> <20210325191435.GZ1719932@casper.infradead.org>
 <87a6qrx7wf.fsf@meer.lwn.net> <20210325221437.GA1719932@casper.infradead.org>
 <87wntux3w7.fsf@meer.lwn.net> <20210329144204.GF351017@casper.infradead.org>
 <874kgtq079.fsf@intel.com> <20210329185843.GK351017@casper.infradead.org>
 <87tuosoov6.fsf@intel.com>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <0ad14d9d-5694-432a-6376-b776a4acebfa@darmarit.de>
Date:   Tue, 30 Mar 2021 14:43:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87tuosoov6.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 30.03.21 um 13:35 schrieb Jani Nikula:
>> If the introduction were "/*rST" instead of "/**", would we have
>> consensus?  It gives us a path to let people intermix kernel-doc and
>> hawkmoth comments in the same file, which would be amazing.

> If you want to allow two syntaxes for documentation comments (current
> kernel-doc and pure reStructuredText with just the comment markers and
> indentation removed) I think the natural first step would be to modify
> kernel-doc the perl script to support that. It would probably even be
> trivial.

My 2cent: to tag the markup of the documentation, in python they
use a variable named __docformat__ [PEP-258] / e.g.:

         __docformat__ = "restructuredtext en"

[PEP-258] https://www.python.org/dev/peps/pep-0258/#choice-of-docstring-format

 > Perhaps the bare minimum is running rustdoc first, and generating the
 > results into Sphinx static pages [1], to make them part of the
 > whole. Even if the HTML style might be different.

Cross referencing will be problematic, I think.

   -- Markus --
