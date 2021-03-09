Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0AB33237C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhCIK7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:59:18 -0500
Received: from smtpweb146.aruba.it ([62.149.158.146]:60781 "EHLO
        smtpweb146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCIK7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:59:05 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2021 05:59:04 EST
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id JZy2l4qm81jmzJZy3l1hy6; Tue, 09 Mar 2021 11:52:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1615287122; bh=EwLcXwOBzwPMvmHIBLCZ3YWywv8x3MhkG7IQKLMY8tg=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=MBmAt6GvRj+Ya2t9oKtFNO2qsMR9KBfsrEAIVm+fU3bHB4kZ3jf3DX8dCZzvt/eJL
         ALufYIZL1nCnJNQrHDa1iezwXDel2KLpZTZQBzr5v4uMp5Ei5GM0NWPbR73/3GVKSV
         8ZE+poUJ8euED25cbqq1qQed0474rdpOqRMF8B2dA7xJTPVIFNG6Pks6FC6y1JwT0q
         oNqhMvna1e95mr46cA8s8bOrP7FOk7tpMTUpmAhvzzCsT2Qc7ddEt/uj6RohU+ms+p
         8k9/rIdhLVlvSEt64s97mhz+0c6PUD1lgzQ4RMqfazIhLHfzfmrU+gCiiX33Dn3PIR
         qdEQEFommwi+Q==
Subject: Re: [PATCH v1 1/7] pps: clients: gpio: Bail out on error when
 requesting GPIO echo line
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
 <YDkp5Jh8ZXWgr+zl@smile.fi.intel.com> <YEdSVD+hU+Il5W/7@smile.fi.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <ca333fca-e2d2-c2fd-fa4f-8238ccef1be1@enneenne.com>
Date:   Tue, 9 Mar 2021 11:51:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YEdSVD+hU+Il5W/7@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMmfQKCxLMN2g+TFmA1nwu91Xbygu72nMz3WyURCLEAnRlf2Tran2WHwMNRApsic2OE5sAP8hluJtVNQu6vVPRp60R3RXC08wNgSTrl7gWbbSDUT4Ak8
 wl+D1NRuxiAty4uJn8pVLy3k9jCYtD1sikWyaX/0QjajN2tVnjyQfwzghzJEFgShBJIs3ylYznwvk1Ncl8V6O0hbHL5/b+m+YWzC5YVxt7vZ+mjJTBEeq5PG
 cH5j4F28OdW6ceWFA9NdQrUDJkYJHm5emm3e82wxrSUrRBK647ZuDIwQ9nrP+NFY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/21 11:47, Andy Shevchenko wrote:
> +Cc: Greg
> 
> On Fri, Feb 26, 2021 at 07:03:32PM +0200, Andy Shevchenko wrote:
>> On Tue, Feb 16, 2021 at 01:31:48PM +0200, Andy Shevchenko wrote:
>>> When requesting optional GPIO echo line, bail out on error,
>>> so user will know that something wrong with the existing property.
>>
>> Guys, any comments on this series?
> 
> Greg, seems PPS maintainer keeps silent, can I route this series thru one of
> yours tree (resend implied)?

I'm sorry but I suppose I missed this patch... -_-'

Can you please resend it to me?

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
