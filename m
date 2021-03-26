Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDCF34AFF8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 21:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhCZUOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 16:14:23 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:27732 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhCZUOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 16:14:14 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Mar 2021 16:14:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1616789654;
  h=to:cc:references:from:subject:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ghNnyhfIVhn72/V9a1kb62+qEDV4uYqMnOoklcejqho=;
  b=TNHZfCs3L2zfHVajK4CAtadbU4JUaULgx2eUfqvj/jUda3lJBN3kj0UO
   diGAdtV8Y41FN5Nikj8TflQ+psOsriEg2ccqvr7A56xdt2PRINUu35Wq/
   OV8Ev3C+yzjy2HSvYXqrTCgkA/XHcNvzo4hAodxEeBn4NM4DMaDU4zrQ/
   o=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: Yw7/j2rWAfFxbRPhLia/rFKVWXyy7SpYK854v4HaWw9d3my90xJ9dbEaMohuaBkDpQ+mrYmxxY
 iB1Znhea/QVNKBbOUWQBqdtnQX+e6Oa3LdcFM+GB1LadwctI2Y0fJZIiTbC1zp8+V7MuIwS3Q9
 luaGJ4XAFFXq9Ibo93vXfWjUdCtmFRng3GtvJU67jROdShZWnH80kJjDXLOLj3LfegD3I3sq8Q
 vgg3y0PFi3dQr2ytN9SwZnDFsQtAES/iLnqNZjRqnRSQZFF7Vl9cZ1WHdIEG/owXMI9pqMB3qE
 Vlo=
X-SBRS: 5.2
X-MesageID: 40232697
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-HdrOrdr: A9a23:Mza+JKtNK+OoHu8xSbwIRSsG7skC/YYji2hD6mlwRA09T+WxrO
 rrtOgH1BPylTYaUGwhn9fFA6WbXXbA7/dOj7U5FYyJGC3ronGhIo0n14vtxDX8Bzbzn9Qz6Y
 5JSII7MtH5CDFB4frSyBWkEtom3dmM+L2pg+Cb9Ht2UQR2cchbjztRICzzKDwTeCBtA50lGJ
 2Aou9OoDS9cXoaB/7LeEUtde7FutHNidbaehYAHREq802jijmv5b78HXGjr2gjehlIxqov9n
 WArhzh6syYwo2G4zL/90uW1ZRZn9P91sBObfbstuE5Iijh4zzYH7hJdKaFuFkO0YeSwXYs1O
 LBuhIxe/l0gkmhA12dhTvI903e3C0163nkoGXo80fLhcDiXjo1B45gqOtiA2PkwnEttt19z6
 5Htljx3/E8YGKi7UaNk+TgbB1kmlG5pnAvi4co/htieLATdaNLqsgn9F5Vea1wbx7S0pwtE+
 VlEajnlY9rWG6dBkqp21VH/MahRTAaEBuAXyE5y7ao+gkTtnV4w0wE/dcYj3cN+bksIqM0l9
 jsA+BGkqpDQdQRar84LOAdQdGvAmiIeh7UNnmOSG6XW50vCjbokdra8b817OaldNghy4Yzoo
 3IVBd9uXQpc0zjJMWS1PRwg17waVT4eQ6o5tBV5pB/tLG5bqHsKze/RFcnlNbli+kDA+XAMs
 zDe65+MrvGFy/DCIxJ1wrxV915Mn8FSvAYvd49Rhanvt/LEIv3rebWGcyjZIbFIHIBYCfSE3
 EDVD/8KIFr9UawQEL1hxDXRjfDYUr60ZVsELXL3uQaxYQXX7c89zQ9uBCc3IWmODdCuqs5cA
 9VO7X8iJ62omGw4CLp4gxSS15gJ3cQxI+lf2JBpAcMPU+xW60Eoc+jdWdb22bCAhd+SsjRAT
 NOvlgfw9PxE7WggQQZT/63OGOTiHUe4FiQSY0Hp6GF7cD5PrQ1E4ghQ640MQnQDRR6lUJLpQ
 54GU45b36aMgmrpbSujZQSCu2aXcJ7mh2XLcldrm+ak16dq8EpTn4yRCWvTsaTvAYrS1Nv9x
 9M2p5apIDFtSekKGM5juh9GkZLcn6rDLVPCxnAWJ9ZgYnxeAZ7TX6DgBuTjx1bQButy2wiwk
 jaaQGEc/DCBVRQ/lRVyLzj/l9PemKBRE5ocXxhvYphFWPJh2Zr3YawF9+O+lrUTmFH7vAWMT
 nDbzdXGA9oytyt/DO+mTqJFxwdt98TF92YKI5mX6DY23urJoHNqLoPGOVM+o15cPr0tPUQbO
 6ZcwiJDT/xBu8zwTaJrnI9NCQckgh8rdrYnDneqE620340DaCMfBBIR7QHL8qd6GahbfCSy5
 l9hc80u+z1EmiZUK/x9YjnKxp4bjXUqiqKasttj7Z+l6c7rqFyEJnWSiGg7gAN4DwOaOPP0H
 oDS6F66o3bMoBhf8YuaztUl2BZ4+inHQ8OiEjKGecwclEmsm/DM/6I67TOr6AzAkfpnnq4BX
 Cvtwlc9ezCRS2NyPozDL8xO31fbCEHmTlf1dLHU43bEwOxce5fuHK8L3+mabdYDIyIA68ZoB
 o/w9aGmYasBmbF8TGVmTtwOaRV9Wm7Beu0HQKXAOZNt+WABm7kuNrj3OeDyBHtSTW6bEwEhY
 pKMWwoB/4z+wUKvckQySi9Sqv+v0Q/tUBRiAsXzmLQ5g==
X-IronPort-AV: E=Sophos;i="5.81,281,1610427600"; 
   d="scan'208";a="40232697"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyM35YG4NguzrN4q6sO5Nfw53nZN1SKYQJX7OzZNqzUdJll3rV/RTj4ud5QpsF5UXKjdz55Ynv/tm/VUGXzU1VpZhGOAr1JrdF+EVRvEX4YoFfvwoG7ZmdGmt9m8X8irXetxl8BEReyCdE3ZBjvaLTcXyxl5PBz3R0sQeCaY3x7ezrtBeR6q19ncrjDiUV57uCGEmxIWCyCO09CxntCx0CykHQUUA3fITgI39IEu0D7bAoeyv65sF/9qBAk+zo9bed7BKPfml+6uB3DiIVemi0Qi3SUvx5USvo/JvRpltgbxx6Uip9uECfzs/K8iIohPO+2+R3kYCX4+v9jzijCjew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U3ractI8w9GTJlwCHZ8eIquI9gjbtbD/fYwQqvhjnw=;
 b=at0S727Cja0pSCqIxuelajDyCXtsw6j9eH67qz16n6tK1YD0LgTMsH9aKvOKYD9TdRavzNRWua/SmG5cAFALtMkVaimA/7GFKXIqfWvg66a4NWYp72ynWGRWdPh1486Fv8h/ljzPUQQ+DUk5vK7ZKIP9LOeJwrZ/MPwesnjjamqPGzJJq6ecjcrlOdi9rHGrPNz13u0yHDIK04//T7dJl4qYwa7lTtCL1pYnN+RTIkDibdORTajeu+PBPi/1XU6Yt2u3D0MjPouu0IJsmeVqJhvuJVz0B9cZh6EcNlFrWtE7rxOk5tkvqma38n9TXkEMeZLJv4jcvwtgRC72iT4Lbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U3ractI8w9GTJlwCHZ8eIquI9gjbtbD/fYwQqvhjnw=;
 b=VS53EQgKg+YWXFRFDRGLpY/rEdr+dgnVZ84yNXl8JuqO/8wO50yotaQE874QG281C/C1HJkEVrkNCMjTSKjKFvSACqegr3sAuN6KCvfXlIgqlt70q+dP7uWfbhN+M8uGOCMfl4ySYRH2Yo50mKSJCxQDtouGq8L6efRtP2NYowA=
To:     Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>
CC:     "H. J. Lu" <hjl.tools@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>,
        libc-alpha <libc-alpha@sourceware.org>
References: <CALCETrURmk4ZijJVUtJwouj=_0NPiUvUFr9XMvdniRRFqeU+fg@mail.gmail.com>
 <87a6qqi064.fsf@mid.deneb.enyo.de>
 <CALCETrUM1=Db3vmQAhPkt=SktL7+dtUrt5Ef6BP3T1Q6HY3Bmw@mail.gmail.com>
 <87blb5d7zx.fsf@mid.deneb.enyo.de>
 <CALCETrUXMnutTV=SEs6ot58j32_5=K5Z=G7_57gVZt_GFcuDiw@mail.gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Why does glibc use AVX-512?
Message-ID: <25dd7d39-ce7b-2f4e-a6eb-981038f74c9a@citrix.com>
Date:   Fri, 26 Mar 2021 20:06:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CALCETrUXMnutTV=SEs6ot58j32_5=K5Z=G7_57gVZt_GFcuDiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-ClientProxiedBy: LO2P265CA0217.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::13) To BN7PR03MB3618.namprd03.prod.outlook.com
 (2603:10b6:406:c3::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb7ac413-06c1-49c5-b05f-08d8f092b908
X-MS-TrafficTypeDiagnostic: BN6PR03MB2577:
X-Microsoft-Antispam-PRVS: <BN6PR03MB2577E9A7B3915C9F2FC75A52BA619@BN6PR03MB2577.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7diBO3p2Yi+Sg/2u3uTIOM/F+Aq1zQmbovgS2+meha09ok76+27p0xlb+Lb4fsSjmSuF+NVsgPGwIN3rEs5CgS0Ryp1ec+ynWxJL9c9htk2fIqhB4IvJW+bEf7T8u9/Psm+c+niz5dFT18dHdbSSGZGSZF70yuSZPKKyYY4WBIhYebMnlk3SWpWL6M+o9B3GnFOeBGEpc3wRQqI4vCVJsphP65UKGv/V86azrwlof9ZpgfxN2353KF20I2CFwjgclPEfqTkrjwzhUMNA/xa6RtkxlKGrsv4gej6rTPDczmeDCL8YDXioBRwW9RJGnjKI+1ZU3Po88KXB6rBkeu5VkrCz5/9ruR+wEdHIVfFnUusUjCFIKr4QyuVd8fTRK9aP0v8Gt2JsAZ5B/NegQJ6NjguAJHmydJGQqWLp0u1ahtA7P0vbqbuKZUlgQgEDcUd5yHV8EQ+3XhVkW0T4JDQeStWz5P9UVOgoJU05h5IZ5A15woD2HT11tUSSZO9vJI+pMWNrJvU7PdJ4IZC67sc9uhBQwlsGVHneXU/8GQz6eF84qetIBp6kDH5+cJ8AL9OiLoehZ+uy5YOUDU9rBV2sHCbl7LES8iTCvcdcq3zaFr0zbxP0Y0Ic3x503p89UrlCSGimmlsmGvCJtkS0vKIl+C/itEJo3QD8M3YrGtAqToNeNY0S6f1suoM1ctV5bo0S6ryyMcnru3n7yUxdqBJauztjp7gzCxk852W0ZBrbMx95EZ88BO4wwDr5aJL/VusyR99eD2QQjofJD68kwqdvJfRtNKpEmOPn/qv3iXhkFfc/qAvGNxv15KWepqW2k7GB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB3618.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(376002)(346002)(366004)(66946007)(86362001)(66556008)(66476007)(2906002)(31686004)(31696002)(83380400001)(110136005)(54906003)(36756003)(16576012)(53546011)(6666004)(8936002)(186003)(26005)(38100700001)(5660300002)(6486002)(2616005)(478600001)(956004)(4326008)(16526019)(316002)(8676002)(49934004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WTBESXhLUmx0b0xsRmZwNVR5NU1ITllkY1ZPVEJaREJUaVQxdE42VXVYbzRW?=
 =?utf-8?B?dEFjVEw5SEtreVUwRGgwaDQxSlVWdHdscU9KditybWdsdE1xbElMZ0lpU2dP?=
 =?utf-8?B?aU5DeCs1Y2ZzbmZieUdnU1JsbXpLREwwYm1XSThxeFlMbWhSZ0hXNTI3V1RJ?=
 =?utf-8?B?N0EwMmkySVZMOFM1cTZiY1M4Umd5dGxQYTNId2Y3cEE3OWJRZ1pWMnRWVlly?=
 =?utf-8?B?UFEwTzJaNksxeDI3bk9tVlhEQnI5c2hzNkc2SkQrbklRNWY4MWIwYitpUmFo?=
 =?utf-8?B?VkVWWXZYOXpkM0lwc2Z4WWdyMEN5UlRBME4yT1RtSFhUalNtLzdwWHB0dHBk?=
 =?utf-8?B?NnBLUTVqcWJNODhpRXRYTVEvWG1UdWFTT1BYdUNRWUIvZXk2cEo0SnRBVnNt?=
 =?utf-8?B?RGhZMGhVOXR0bllvb3FVUGxBKysxd3BZOSt5d2ZIcDl2SDVqOFRwUWdoblpY?=
 =?utf-8?B?Tlg4am9JMmN0UmRoSCtiVGplN0g0RTRIRTlseXYvTUZ5TEN5dzg0M3g4ZWgw?=
 =?utf-8?B?YTlzTmFVSTlYUVcxRzdhRmhnRkY0V0FuVW5DaTY1ZEJDMGFlWlcxKzR2YVNj?=
 =?utf-8?B?WDBNTVB1N3lCMG1sQU8rUE11YVhRNWpOU3J1endOamlpREtGcjBxc0I0RUNB?=
 =?utf-8?B?b1MycmZodkkwaUgxMHJ4RzczWHhqdDNkUVBhNU5kTElwd203cE9WbWJSRC8w?=
 =?utf-8?B?YUpWQWhjazdoVXpCNlc2dGN0RUF3S25IMEFHUzdYMVZobTBlWmhna29nZ0RN?=
 =?utf-8?B?dkgwTHAxUGMrbC9ycVpFQTl4cUdOdzBvT1RRZ1QxS0xsT09kL0FCcmtTM2xt?=
 =?utf-8?B?Z2RvUkVVNllHYlcyNUZZWnc5OUpoWWRpNWZZbmNyTktrcnMra3RlTHl6ekFT?=
 =?utf-8?B?R2w5MUhyK2daR0NtY0tORVFFd25BRGNkSUhmNjdSS2ZLOHh5TG5zTVB6OFlo?=
 =?utf-8?B?RXI5bnNLbDdMTFZyQmhGNmJtNSt3bmp3QTI3d2hxWkc2UnBQUWZ1Z3NiTkwx?=
 =?utf-8?B?STc0R2Vkd01HbXNTMHhxYXg0TStOd0tucWlwWDkzM2plMDdrSE5SUmV0RTFY?=
 =?utf-8?B?Wi9zRDlRcWhWYlhoSTYwN2xqQk9qQXBHdWoyRCtrUlV1YUhqRk5PSzNKOHZp?=
 =?utf-8?B?M1l4dWtneEY2eitlMWN3NTQrcFdTRzk1UUpKQktoVGJJdlIxTkFwS2tpR1pB?=
 =?utf-8?B?ZDVtYm4rbmU2UnBvRUJuR1pOV2VIVWpCUlQ4VHA2bUVHZE4vZm91SXhHaTlI?=
 =?utf-8?B?Z3ZoWDFTVFpyYndlbFVuU3l2OFhyaUNSSHN5TldoKzRjVW1FQWtsRWJFSm9K?=
 =?utf-8?B?K01YK2RDb05QVGFyM1ZjbUhTZG1sL1VsTDBBSkZQNjNPRWVJdlRta2k3ZTRr?=
 =?utf-8?B?aG1wRVZ2K01mSWZUUGVFQWdjMThvMGViVm0yckI2ak1XODExZnBnZ2EwMU40?=
 =?utf-8?B?N3RzODRpV1E5Tmp1eWp2dTdhYWkxaTQvbWwwTmErQ2ZFc0dqQnYwUGFLbVNJ?=
 =?utf-8?B?QXNGWHg3ZzF3V3owYUNGK3hIY3RuenFxdW1FampEVGRoUW51TUNDUSs1WW9o?=
 =?utf-8?B?M3l0MHc0V3ZBMy9BL24wQmdrOENwMmgrd2dhdWZzbkJlQStRSW4wdTZOck1V?=
 =?utf-8?B?SVg3eGFPYStDRTZyRTJZZmhFTlJxdWdoeGZJZlRkeDlwbjg2Qy92MlJNcmcw?=
 =?utf-8?B?V0FtZkhYRkZabTZrTm1MdTJQNzhoK0pta0NGRkNkRXhWWVJmMW84MXEwR2Vl?=
 =?utf-8?Q?ZGejPwbsSOhMh1Y6tlxDM7TNbKEKcGpQZ/jflvl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7ac413-06c1-49c5-b05f-08d8f092b908
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3618.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 20:07:03.5909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQsy66rKVu3gn1T3Z0ZONTAy37c92UCWjCL430rebyksijJm5RISzr8uI2CFKFMgPAYB8JKuN76fpHrd7aslglmhQoNhpT09d5wjSkh4Q68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2577
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2021 19:47, Andy Lutomirski wrote:
> On Fri, Mar 26, 2021 at 12:34 PM Florian Weimer <fw@deneb.enyo.de> wrote:
>> * Andy Lutomirski:
>>
>>>>> AVX-512 cleared, and programs need to explicitly request enablement.
>>>>> This would allow programs to opt into not saving/restoring across
>>>>> signals or to save/restore in buffers supplied when the feature is
>>>>> enabled.
>>>> Isn't XSAVEOPT already able to handle that?
>>>>
>>> Yes, but we need a place to put the data, and we need to acknowledge
>>> that, with the current save-everything-on-signal model, the amount of
>>> time and memory used is essentially unbounded.  This isn't great.
>> The size has to have a known upper bound, but the save amount can be
>> dynamic, right?
>>
>> How was the old lazy FPU initialization support for i386 implemented?
>>
>>>> Assuming you can make XSAVEOPT work for you on the kernel side, my
>>>> instincts tell me that we should have markup for RTM, not for AVX-512.
>>>> This way, we could avoid use of the AVX-512 registers and keep using
>>>> VZEROUPPER, without run-time transaction checks, and deal with other
>>>> idiosyncrasies needed for transaction support that users might
>>>> encounter once this feature sees more use.  But the VZEROUPPER vs RTM
>>>> issues is currently stuck in some internal process issue on my end (or
>>>> two, come to think of it), which I hope to untangle next month.
>>> Can you elaborate on the issue?
>> This is the bug:
>>
>>   vzeroupper use in AVX2 multiarch string functions cause HTM aborts
>>   <https://sourceware.org/bugzilla/show_bug.cgi?id=3D27457>
>>
>> Unfortunately we have a bug (outside of glibc) that makes me wonder if
>> we can actually roll out RTM transaction checks (or any RTM
>> instruction) on a large scale:
>>
>>   x86: Sporadic failures in tst-cpu-features-cpuinfo
>>   <https://sourceware.org/bugzilla/show_bug.cgi?id=3D27398#c3>
> It's worth noting that recent microcode updates have make RTM
> considerably less likely to actually work on many parts.  It's
> possible you should just disable it. :(

For a variety of errata and speculative security reasons, hypervisors
now have the ability to hide/show the HLE/RTM CPUID bits, independently
of letting TSX actually work or not.

For migration compatibility reasons, you might quite possibly find
yourself in a VM which advertises the HLE/RTM bits but will
unconditionally abort any transaction.

Honestly, if I were you, I'd just leave it to the user to explicitly opt
in if they want transactions.

~Andrew

