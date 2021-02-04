Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE45B31010B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 00:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhBDXt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 18:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhBDXtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 18:49:51 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2963C061786;
        Thu,  4 Feb 2021 15:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=RxMwGRAzLa4YpLotu83oCMZFWVpTttXVPtTu6l0zD0k=; b=QDfSlqpKht8ZMUBHklTZDTTRPy
        6elMpT6y/AZODgS+QpQlXjus+61CNPBjAYOc9y7TUYILhHTF1q1d4C2f4U/RmRPDiDWen1rK1QJv6
        rnHTv5QOkKeyuqoK6Vp7iOoet129uXf2RcGkBq9npaPGt1sHLjeDz/FNQT6ueX3Im5QCN1zx6uWbi
        QiGze4ToLyhArVL7wW9Xxgy40vYIQdVlxzfaOXo1nkn/OC42XwXpTO350R75ztWsZCu3S/KgCt39i
        WhGrG5oG1mOpOA2NgHeAeyQxYVMcRdSQ3EIFMjV9+/edGTwXVo2GqC9OH/pO+7KBL0CDRE7IFXJuq
        vVyO93qA==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7oMw-0005r2-Qz; Thu, 04 Feb 2021 23:49:03 +0000
Subject: Re: [PATCH 0/2] docs: Add support for relative paths in automarkup
To:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@protonmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
References: <20210128010028.58541-1-nfraprado@protonmail.com>
 <87o8gzxvjl.fsf@meer.lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <10b0104e-7d89-fcad-a27d-6d1463bf325c@infradead.org>
Date:   Thu, 4 Feb 2021 15:48:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87o8gzxvjl.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 3:28 PM, Jonathan Corbet wrote:
> Nícolas F. R. A. Prado <nfraprado@protonmail.com> writes:
> 
>> As Jon previously noted [1], it would be nice if automarkup supported relative
>> paths as well when cross-referencing to other documents. This adds the support
>> for it, and documents it.
>>
>> Jon, after applying this, 43bc3ed73639 ("docs: dt: Use full path to enable
>> cross-reference") could be reverted without the link stopping to work.
>>
>> [1] https://lore.kernel.org/linux-doc/20201130142404.6ef6689e@lwn.net/
>>
>> Nícolas F. R. A. Prado (2):
>>   docs: Enable usage of relative paths to docs on automarkup
>>   docs: Document cross-referencing using relative path
>>
>>  Documentation/doc-guide/sphinx.rst | 30 ++++++++++++++++++++----------
>>  Documentation/sphinx/automarkup.py |  7 +++++--
>>  2 files changed, 25 insertions(+), 12 deletions(-)
> 
> So I finally got around to playing with this set.  One thing I found is
> that some of the references that were being caught before were not
> now...  after far too much time, I figured out that the problem was
> references to .txt files, of which we have quite a few in the docs.
> admin-guide/kernel-parameters.txt in particular is quite popular.
> Before this change, those were being turned into xrefs, afterward not.
> 
> To address that, I applied this little tweak:
> 
> -RE_doc = re.compile(r'(\bDocumentation/)?((\.\./)*[\w\-/]+)\.rst')
> +RE_doc = re.compile(r'(\bDocumentation/)?((\.\./)*[\w\-/]+)\.(rst|txt)')
> 
> That seems to make things work properly again.
> 
> While tracking this down I put in a print for failing cross references,
> and noted that we have quite a few; it's a useful way to see where the
> stale references are.  Maybe I'll try to hack together something to make
> those stand out so we can fix them.
> 
> Thanks,
> 
> jon

Hi,
I just sent a patch for file name changes in
Documentation/input/ff.rst
(https://lore.kernel.org/linux-input/20210203050842.24190-1-rdunlap@infradead.org/T/#u).

I sent it to the INPUT maintainer because I thought that he would
want to review the changes.

I could resend it to the DOCS maintainer.  :)

-- 
~Randy

