Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997333AD42C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 23:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhFRVM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 17:12:26 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:1296 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbhFRVMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 17:12:24 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jun 2021 17:12:24 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1624050615;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aLMsuXLCsllpZFldY8OT15tgzAl46T576xjLKmM9eOk=;
  b=JqkyOQrXMcwTXdQ0MqGrM3ENRqwpe2iK6fmFPRdWwB3IEtAGpptGBvzH
   1xE9MxhpCvd7nTU2NhXGCTbEodvRzW3VBk1mUiP65vU0oqQHNaG1qRDGc
   koYT25Z8AxIsWMkqi8Kael304XP//dJ7ZpywgMzFFJw/cXdK6seqHQ+F6
   o=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: VNjKez3ptyZ7SSVXgfZxYnNiPNVaLAA2ll0P2pUjNkQN2S/6FshCZTnGDuWEol50lETPo3B9C8
 Xs5W9bwul4fy6kI1DgwHi+wgPE9xOv47FJ9ciTxlbiHbX/wdsT91fuY6bLJLIlSr/NYu7cfAAS
 A8jATjXVfUI1UxfmyeA6RFSeHVwQ7CogPNPzNAiIQdLi0jGvqKv5spT662k9VFoOX9ymNFlXhd
 QgGaAIaPYqv9qXz4yEYOi7MtuS71uDn09irsH6oyzhmdd/PDfV/QHuZOSFgWBNRQZ2wFlTDGF7
 uZk=
X-SBRS: 5.1
X-MesageID: 46860835
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
IronPort-HdrOrdr: A9a23:cQwIuKqzpRmtaXZXw4YKlBcaV5vPL9V00zEX/kB9WHVpm5Oj+f
 xGzc516farslossREb+expOMG7MBThHO1OkPcs1NCZLXbbUQqTXf1fBO7ZogEIdBeOjdK1uZ
 0QCpSWTeeAcGSS7vyKkjVQcexQuOVvmZrA7Yy1ogYPPGMaH52IrT0JbDpzencGNzWubqBJca
 Z0iPA3wwZINU5nFPhSURI+Lpj+TpDw5dzbSC9DIyRixBiFjDuu5rK/Ox+E3i0GWzcK5bs562
 DKnyHw+63m6piAu1/h/l6Wy64TtMrqy9NFCsDJos8JKg/0ggLtQIh6QbWNsB08venqwlc3l9
 vnpQsmIq1ImjLsV1DwhSGo9xjr0T4o5XOn40Sfm2HfrcvwQy9/I9ZdhKpCGyGprnYIjZVZ6u
 ZmzmiZv51YAVfrhyLm/eXFUBlsiw6dvWciq+gOlHZSOLFuKoO5lbZvu3+9La1wWh4TsOscYb
 BT5YDnlbVrmGqhHjTkVjIF+q31YpxbdS32N3TruaSuonVrdT5CvhAlLGF2pAZJyHsHcegz2w
 3zCNUjqFh/dL5gUUtDPpZJfSKWMB2AffueChPcHbzYfJt3cE4l/KSHkYndotvaIqA18A==
X-IronPort-AV: E=Sophos;i="5.83,284,1616472000"; 
   d="scan'208";a="46860835"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akeni4rJx21m5e0ZP9C3t+x85RLpUepbX7kyXKu+dcIrJWWzcfDra6UOd2b8dxoNdJqlKuIl/DPFVQbVzh2bRq8ufJ3JHNVIl7Dma7oYeL6kyw743LehzETisjLp3Q8/5wv8I5Wy7OSryMyA8O3aR+Un8gQWLMukMyGgb1bdxF0KH3awYbFU0UO37p+PdvUkrXzwHnPagNfrpji6iw/Bxb/dhjhZvtyaM5at+0dTW+kd5C2eMEZ0Fn88hzg8kh0oiQJR476WNTJEsGhuq5nrkj2/574AN6GDXBWEK7pLOR4tYcNVQJwx2h0bC5vBQhjP4GAm3tLeYpVYt7lTSHqoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfLR7wkmxE9Jo89PqdEuBA1b6xJ7tP036iKTQhqbm90=;
 b=eb/XBneeTYP87S/MpF6NuZtjXNlDLj1SwgsGs0OkpBzsHU0JB5ACDrlz6RIQoCa9e/VxgCZb70bgojex8LyjepUtsLZxGSCGQrfVW12QUDjSu8m8r7EeZOKBndnv/G0rA85b+gbkVscQzcObHWhB+MtfffavY3tqMZIgluqLGLjrmHnjQmcFuhoMfEfHPjwrWv+o5CC/tnjZAIr7CuA4QWpXK5KVLMdi6SHaRMiPO9iinAbeKzqgfcIZWiNHc/sP57oYTvkyLLdB8p/MuQ8cdEPYRpqILBlmC7fVSOR6X+UJE+C5z2qYzO8248VTQ3fR6bsvBe/XV+/reNE2vST8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfLR7wkmxE9Jo89PqdEuBA1b6xJ7tP036iKTQhqbm90=;
 b=BGmz0uZ+geTLNBf5LrIhJJRjYl07FCMvEr9GRADikEZLU7n1JrrJqpNNFbTEQKrg1U1b4aK9KP+xbWUYKybtyZScSmLjtuyVn6Bs7/koYyDJFdEMcmSZfC4AvqrO6Wjkg5tv+lWStjmdhG8KB3s2OseuP890oIvq/h5W+hqxp6s=
Subject: Re: [patch V3 61/66] x86/fpu/signal: Sanitize the xstate check on
 sigframe
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <20210618141823.161158090@linutronix.de>
 <20210618143451.325530702@linutronix.de>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <e166f71b-bd83-04b1-27d7-cea59ebe81fb@citrix.com>
Date:   Fri, 18 Jun 2021 22:02:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210618143451.325530702@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: LO4P123CA0218.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::7) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db3b8c5d-99aa-4174-5af4-08d9329c7748
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR03MB5663153EB74A4A39AE6829C1BA0D9@SJ0PR03MB5663.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwHwxIq9plmYUJug5DTTTf5R48JoxAceirGjb9IeDpq5diBmjkAXMKZFBW5DvjFA5ihOF+XnNnKuE4SoFZZF9iUw2g/69NyP2d+GNNePTIc9mEbmt05PTEMF1Cw1+UqSt0dhVyxy+VPwxoBI98Lk0EkpqYjHzNmDfRTOD2K/v6OCdnlyqUKeqwGxoBZ1/zOyvDEKNCDYFgaJ9HzkuNT9YkgIuljElw0rZHTraTGpnJ6ChHv4rCqNd7y6jSpOh7ffb+xvvacaDtXemlio1j1kGkifyt3WypDHV4+0t61Hs4buqHy+dogWqI9tWcJbjHGnax2jqgo193QLIkQ2KywmDQo1aYTYSX4bj0iBoVsI38bosZN8utXqHLA0fobIvQUAe/WjaWqofDHqy0Lyf70NWv2aA8ku08o7c2BNuAYN7O+kwsCFq/mkyW0PhrTvCKOPCptR9l45YiBoY3L7ao+PLgSqKJTiKPlZ66xWS/6XjyLsiPG6S1CsHHYPuCgIhtypZYwgTcLszS9S/P+01thd4vaIRl6NtcOoptXZ8W8nIRXVwPocgf0a82lfYkfCb60fmb+IBsCFOUa06Pcp7FQw/d8/BYbmksI5gdf51RgIE4qyMI4x9Vy1DV6DROQ5wh5YF7QLNGmGAcsnLg+59DhA2DDyjEZUoTOwjHZGc5i9SqyqCkC40JHfBXGaK8jQ6DXf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(316002)(4326008)(36756003)(107886003)(31686004)(7416002)(66556008)(110136005)(54906003)(66476007)(16576012)(83380400001)(16526019)(38100700002)(186003)(31696002)(66946007)(2906002)(956004)(53546011)(478600001)(8936002)(8676002)(26005)(4744005)(5660300002)(6666004)(86362001)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2FjQkJLWWJ2aGRzTUlFakVPKzJKRzVPYXl1MWw4UTNxTGFkUWJuWVNIRGNr?=
 =?utf-8?B?U2kwNGZ5Ujl5MkM3NUlkMXNLTjE3WGdOOUx3Tk9MOC9SUDBKN0h4bERTN1A0?=
 =?utf-8?B?TmdKclMyZzRXSGpnMDBrc01uUE5SVFJteDhHeGFGZ0pHZ285NlpiVVptaWlL?=
 =?utf-8?B?emV5dGFsTEk4TndNeURHV0ZvckhZM2VHenJoZWtSRUd6WUxENEY1K0NlRU9l?=
 =?utf-8?B?NVoxWWNpMWE1MldMb29CTmNyN1pzMjlyaHZWMWtZa2NrRTk1NEZnZmY0Kyts?=
 =?utf-8?B?V05wSXh2eEl3djl2UHBKbDh3K0s2M1gwanc1OFZOWjBVVVo1ek1FRU5GT1VK?=
 =?utf-8?B?MWEza1RIWitmTEpXN05PQTNoVnMwUE9IbTVaTzBxMnBNd1dCOElvaGxvd1VN?=
 =?utf-8?B?bW82VjVVQU9jYjRTOTN6RUdZUjNkT0k4TVYyS0V4cGFrWERjamJRYjFwejc4?=
 =?utf-8?B?ZDdlakVETHlvQWRoNHcySndsaXozRFc3SGdYR0ROSWh1S2MwTDcxMitoUEha?=
 =?utf-8?B?dVgwUERJSnUxS0VRdTlTRVNvaHl0TXJoOW5SdUhrRlhzSkVZNVNLQWQ1K3pt?=
 =?utf-8?B?UTU3WWNadG9GNVFXa1JZb2VmbzRqOHhuSWxWRHF6dVNXTjlCK1JnNUF4RWxI?=
 =?utf-8?B?Z2Rha2oxejhyNXgzWTZTeUlFZWZlYTh1OHE2RENMNmFENGZZaXd1dGNudXMy?=
 =?utf-8?B?MlYzbmJwRllzaG8rZTRHRE5zdEdhN3dwTWZjWUZkaGJyWjBQeks0YUU0bWVB?=
 =?utf-8?B?dWxsVEJpNXI3a05JKy85eGZpRkVvc28wWXMrRlF2UkhVRW5BaFFwN0VsZUZu?=
 =?utf-8?B?NEJ1WmZIMzZYaXVZZlBoUm1PZW5vUGhWeWRLU1F6am45eFJGcDJ4Y0lzOUJi?=
 =?utf-8?B?VnJSS1h6ME9kK3pYdVpLSlVTdFV4eloyYnRkeFlhZDlVNXpDTkEvbGpYNnBK?=
 =?utf-8?B?TDBad1RSZTFldStiOGV0OEttcG1RWmQ2b3czZkY3dHFsU0R1cFduRWg1dERs?=
 =?utf-8?B?bTBmLzhBaEZjaThWTExqV2xGTnRKb1hqS0MxaDhUVGprTlRLMGpRRXRSZ2Ur?=
 =?utf-8?B?b3lyZzVxQzNObHZPc0NzaEJQTElqemdCbkFGN2JPRnY0d25yQmVKZ0ZqNk1w?=
 =?utf-8?B?akNpK3FtTjNrRGtvTEVsVDk1b25Ncjk0MWVudU0yMVE2cGk3OW1YbWhiZFcr?=
 =?utf-8?B?NVFVTSt2YTk0Zll1ZUFiVXNLZlZCR1hKU2tUemRGTEQ5SEM3MkdwZ095OUZO?=
 =?utf-8?B?Zm1pL0pWNWZUUVc5RUpRNzY3YmppcWVqNHFJak5tUHQ1dnN6UnIxUjFrTy82?=
 =?utf-8?B?dVl5N0lySnhVZXhLQTViK0hKeHZEZkxuWnBRaDJyZFl5NHhiNkh2S2NZZGVy?=
 =?utf-8?B?TUY1SDhkcDV3RTN6SkdybXkwU0VUZ2JuNnpWVnAzbVBKNExHV3poeVR1ZFZH?=
 =?utf-8?B?VVVsdDlzVXpWaXBTak5SVXpYekVmeUdNdGhQMndLY1FRanRQMmtMZkZFWm5O?=
 =?utf-8?B?R1I5ZWxSaVByTlJnNDhpbHMwTXlqQ1VRZnppOWp4MVNmS2psZjRqaVZ2a3pM?=
 =?utf-8?B?VmhRazg1MDlrNHRwNHhXalBGNGlJYzlqV3RYZDRBakUzRWpXZWYvNzhITEFI?=
 =?utf-8?B?djArbUFZcGVYeks3U0c1VXYrT3dqUDIxeEovTlFCaSthZlAyT2dKSHRnWnFi?=
 =?utf-8?B?bGpobGdkaTcwUjRBSHRPL2JvdGFmUkw0WFRmVkVMV0dBK2pQYXAxdEtnRXBZ?=
 =?utf-8?Q?XmvzUmVEpidNqGqWNhQZLFisoHRjg3Cr7omukGE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db3b8c5d-99aa-4174-5af4-08d9329c7748
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 21:03:04.8262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKzAsgadMVe0SlpARDLMraL8FpHBvhOVx9NzhbDZCQriBQC5V2x5L5YLkoym4zXNLl6TBuva6jfD9FJvvQegjag16EU3wpsfASlUr/8vCxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5663
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2021 15:19, Thomas Gleixner wrote:
> Utilize the check for the extended state magic in the FX software reserved
> bytes and set the parameters for restoring fx_only in the relevant members
> of fw_sw_user.
>
> This allows further cleanups on top because the data is consistent.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/fpu/signal.c |   69 +++++++++++++++++++------------------------
>  1 file changed, 32 insertions(+), 37 deletions(-)
>
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -15,29 +15,29 @@
>  #include <asm/sigframe.h>
>  #include <asm/trace/fpu.h>
>  
> -static struct _fpx_sw_bytes fx_sw_reserved, fx_sw_reserved_ia32;
> +static struct _fpx_sw_bytes fx_sw_reserved, fx_sw_reserved_ia32 __ro_after_init;

You probably want a second __ro_after_init here.

~Andrew
