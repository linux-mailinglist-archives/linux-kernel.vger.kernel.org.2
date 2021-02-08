Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20282312E80
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhBHKDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:03:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:35158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232083AbhBHJu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 04:50:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612777811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MoTBA6avz+A5L1BdaknRfGBP0w5pvSSOGiusH5vYDLg=;
        b=V8EHf/3iHEYlg8oCEopDrfPwpSnRJZHbotdl/3VZvjcRnKLAiYBfUuLlEn57q7d+GwKCf2
        p0sDGsDk2r/IdKR2od8UkH1+zySf2vCmmNW4gxaTekyswxXzjTANm6Fk2cqQFu+X2zbB6a
        tgZtprSKGTYZPMv0XiX2jib5gUKbkYE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B27ACADCD;
        Mon,  8 Feb 2021 09:50:11 +0000 (UTC)
Subject: Re: [PATCH 6/7] xen/evtch: use smp barriers for user event ring
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20210206104932.29064-1-jgross@suse.com>
 <20210206104932.29064-7-jgross@suse.com>
 <2d354cad-3413-a416-0bc1-01d03e1f41cd@citrix.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <dfa40af0-2706-2540-c59a-6593c1c0553a@suse.com>
Date:   Mon, 8 Feb 2021 10:50:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <2d354cad-3413-a416-0bc1-01d03e1f41cd@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.2021 10:44, Andrew Cooper wrote:
> On 06/02/2021 10:49, Juergen Gross wrote:
>> The ring buffer for user events is used in the local system only, so
>> smp barriers are fine for ensuring consistency.
>>
>> Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> These need to be virt_* to not break in UP builds (on non-x86).

Initially I though so, too, but isn't the sole vCPU of such a
VM getting re-scheduled to a different pCPU in the hypervisor
an implied barrier anyway?

Jan
