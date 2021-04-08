Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C05357EB7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhDHJIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhDHJIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:08:35 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DDBC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 02:08:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FGFmQ5mnmz9sTD;
        Thu,  8 Apr 2021 19:08:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1617872902;
        bh=2iQ0KxKS3ScPyUXb+3w5OkbMsrgL2S49tAnm4lp8e5A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PQeNTa9Z7GQdU5rWcP9EymbkwpsAaOorjmNuPTROuQQgHawPX1iSK6Yqn5j7g4ddO
         7IA9WA5RPZKRRwSjVljTKhaSIkgmBl4vs43F0c36u7DEuWu/xLCJ1qkvz/ciZRCjcl
         YWzOVr2rx7BKPeT4ODwx+viHKWiobCEmiZutX6H/ouYKrdqUXxXmZWGm5P2Ytg3eZE
         w8rMnGGmdqt7kA3m9einvJvxYPKgTgc+SGuD2e31X7JkT6NHavE/YRdtq8pijwEIEg
         gdtwzlQIzBn+FF6z4ygu/r+60SYjyKsEg8wpTbDon0GDv2ulZLAQhAe4AsaR35Ufuy
         tjVTmOMobWGrA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Leonardo Bras <leobras.c@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, brking@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] powerpc/iommu: Enable remaining IOMMU Pagesizes
 present in LoPAR
In-Reply-To: <eed000bfa26686f616b91a7ac5a54ff8e3f2cbd0.camel@gmail.com>
References: <20210407195613.131140-1-leobras.c@gmail.com>
 <87im4xe3pk.fsf@mpe.ellerman.id.au>
 <942acb9b23d87594d0b758cc0daf713be836f8e6.camel@gmail.com>
 <eed000bfa26686f616b91a7ac5a54ff8e3f2cbd0.camel@gmail.com>
Date:   Thu, 08 Apr 2021 19:08:22 +1000
Message-ID: <87blapdtyx.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leonardo Bras <leobras.c@gmail.com> writes:
> On Thu, 2021-04-08 at 03:20 -0300, Leonardo Bras wrote:
>> > > +#define QUERY_DDW_PGSIZE_4K	0x01
>> > > +#define QUERY_DDW_PGSIZE_64K	0x02
>> > > +#define QUERY_DDW_PGSIZE_16M	0x04
>> > > +#define QUERY_DDW_PGSIZE_32M	0x08
>> > > +#define QUERY_DDW_PGSIZE_64M	0x10
>> > > +#define QUERY_DDW_PGSIZE_128M	0x20
>> > > +#define QUERY_DDW_PGSIZE_256M	0x40
>> > > +#define QUERY_DDW_PGSIZE_16G	0x80
>> > 
>> > I'm not sure the #defines really gain us much vs just putting the
>> > literal values in the array below?
>> 
>> My v1 did not use the define approach, what do you think of that?
>> http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210322190943.715368-1-leobras.c@gmail.com/
>> 
>> 
> (of course, it would be that without the pageshift defines also, using
> the __builtin_ctz() approach suggested by Alexey.)

Yeah I think I like that better.

cheers
