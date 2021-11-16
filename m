Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2155452B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 08:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhKPHKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 02:10:15 -0500
Received: from mail-sn1anam02on2042.outbound.protection.outlook.com ([40.107.96.42]:20804
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229926AbhKPHKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 02:10:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lya8+7974qHJZYkIE3QkuQNSlbcPU92d2MzUK2bFTYEibKCyk79/qkbU3tjB9LJGMNBCBcNO08fVIADeEPSWSUG1QuL1WB+3kZcNzp8OBOBxNTW4OCuMXwODpe8B2F6lxaqlK0G/xk1v6Hna/vEtAqE5b3j5UzBe8DBhXrlzUOtBzPFVNN7pewDPe/FBzGpPR2j5NxX6Bk4gZf2tC17fxSjXWmSz/dleVFFnAj89LdRaxCZn7WtUrRZwaLLUjKptL/D1QzFwYhSAcpIvCd7Xs/DPEUn3UNi6Z+nSx4WbvGT5gVybR/gNrmRBS0cC6Xup/m1yBGO0L/jc74hpqtmTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDRimyJhEBmK5eNb0wTw/Q86Y4G5tQyvqlbPiaBo72c=;
 b=NmwzVh6/wwqihMUMHctkNZdMUBZzuMYxegbjWh92ziJVRnPSly4QrdIBwcDAIfX8xbY3RyMzi1VVJ+hyBoKcAI8CKfjezxeIsm42U/vRNxSKXpmr70pDQXpIDCMYmImTCKX7KeK+1lx/RGSie0CJoBur4cZIDmO4mrwskIJutWjnmYPYtEvU+VOPVq71c85jsTo8ccU7B2ATs015pcJNDgIlkD7UuOEyXXk375mJW56xwE5yKPlfzpRyZt0ls8J0SEjEelV+0I3UgG1cPaVBW8gwHAYGjEuxund1ecCx2uiQuV7C5lg/MtkyYRUrkOmMgW00L7A3uVT6/NJqj2ii0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDRimyJhEBmK5eNb0wTw/Q86Y4G5tQyvqlbPiaBo72c=;
 b=fM3ztBGJllEmbfE818458aZD39QE4BJ0u+bjAz1Qzoi+DjD0glL29dvPT23hZXvor85jEEnOZ2V27jiAGjcyucHg1ukRHuf0tkdQow0vqS8BioKGWp5RU4C7eN3wjwN6uoVI9C4taYnJWtnBLeOLlV6bmUC+xSH7vTYGPTwwEJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM6PR12MB3628.namprd12.prod.outlook.com (2603:10b6:5:3d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Tue, 16 Nov
 2021 07:07:12 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e953:c93a:f2b0:aa56]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e953:c93a:f2b0:aa56%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 07:07:12 +0000
Subject: Re: ld.lld: error: undefined symbol: __devm_regmap_init_spi
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        arnd@kernel.org, Randy Dunlap <rdunlap@infradead.org>
References: <202111051055.wZupbWYg-lkp@intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <0e2494e3-29e4-7dec-833e-2eeaa71c75d0@amd.com>
Date:   Tue, 16 Nov 2021 12:36:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <202111051055.wZupbWYg-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::23) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
Received: from [10.129.9.123] (165.204.159.251) by PN3PR01CA0022.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:97::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 07:07:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a60eebd-cd00-4d76-5f59-08d9a8cfb64d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3628:
X-Microsoft-Antispam-PRVS: <DM6PR12MB362849CBA6A524687A09EB1797999@DM6PR12MB3628.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:215;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2bJ1xa5ma/GX+oiCDCpxW+w5QaDzCC1relNGdyqfbBex6FLxeDo85SMsEtnZ7nxeb8W27GxucFl5W0L2Hpwv9xYijhaDluR0DcRCvht9fhh3ANev0wXzJc1OlGenpzdWzHoUXTMCaXNn+2iPJV3NwWYseXplEveZN3myof1Eiyr++0VdmFvQnGHCSFkJjUHEMfFt/v6sGrjgh8149pE6tgsMHUXw6HQVmCT78vG9bkXo1H14YK5bozo+7LoZWc2FDVHbgg31PO9tA6z1qAlToprpzAwYsoUk8X1DUj+8jFmtvVKF0bMYmxHA1YydYkrZ8JhClGuHwhE/HHJUKs0CwE38h/YUEm0/clI5WdB68N/hORYBpE26GfWHxJD0BsVUBcjdBi7nrU3Aa3E60b84ykjyPNQwTw4HNZoN83PASRprrx9SOczMSd6ZHtAXsdOxUrZqAL+Knnh1pqdYGJ/fuxTgrnkxqRm3YMbegITHisux8BOUiD6Ug79/6QHZGfjW3s+FsNo2IeTQbL5ZNn6b8bAeDjCqpSLHGKFmGTbd6k3gd9hafcVPRJuqxwxIm+1L+Oi/Gu528OnB9tvSgOg9sviYZkucFaz3zcrtb10FnPFzni4a9HvDu5zh3N9GenZSEp2X/FYuLP3ER+9BwfPQhDOnnfjtxK1s4mk7gh9iafVT8z49RNPWQEMmh0Z0hf3V38YusMrKwVScPiYVPOuaQc/wpqElbGsBG+G3WymgP5DvLYHyAPDNWcnPbMKUz+0WdGZVdliedEab0vmxCumDhJdDZcGfHmsEtwUYXsV+iTeFj0tXvu6LCJVoexjQYM1lbartQtAjeO3x/Fp4KPstcUjhFBF4KMgFShVD7LgA3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(6666004)(4326008)(53546011)(6486002)(54906003)(8936002)(6916009)(38100700002)(16576012)(316002)(45080400002)(508600001)(66476007)(66556008)(5660300002)(2906002)(66946007)(86362001)(31686004)(956004)(31696002)(36756003)(2616005)(186003)(8676002)(26005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?IKue1OjJ0JivY7Md46KV4B9d1cjiQVIyfbQ1j8q7facj+WKQtFS17XQN?=
 =?Windows-1252?Q?3V60le1/M6xuSNFLs6LsTU4DweFWt3UAtyqW6Sb2xXnvS8QCCzY+p3iW?=
 =?Windows-1252?Q?g2lzM+B2RyLmwARsqs/EjhJg52uPzwsPWNv9G861NHCBEfVst9t8gJ3c?=
 =?Windows-1252?Q?9dfGegLeqY8K5j4+5Qt3B8MK+wKQZJm8ChKfCe6z497BIY+Y2kOHzF6D?=
 =?Windows-1252?Q?QGKG2kbmO+qOVwIzla/oGfGkGIRUAHwjQcgcGo6yJqGROyVu9VU/t3u+?=
 =?Windows-1252?Q?VtnSODuhvy6Jg7Pr5J7ejca0VfErh++CqDifGRa5/5sCJLECO73ffkS3?=
 =?Windows-1252?Q?rMNOwFIG7Icc/UH7Kc5qM0tRhSzfR4pkYvBboGJHj1F6yK4lmDqzcljh?=
 =?Windows-1252?Q?dJ+p2X8neqTjoRkWvsrpbARBVoqj6VP9SeTISLTousTnS0OVvpni/Qpt?=
 =?Windows-1252?Q?/FNYMtalXv8Db3/Sil4DpIKoLtHrRoo059Qo7FH8ne21hXCHeoEwXI/n?=
 =?Windows-1252?Q?0Ds9JZyyKXbVpujIpgYPW9gLMw+tTozo+zhGoFQT4ci7ml8nxVzy1s8J?=
 =?Windows-1252?Q?D4C/A3VjdkSoBTfGICOGMo4R2C58J9G0+4TpNbgJj8kULd9Q1rOzPtQ/?=
 =?Windows-1252?Q?P9nDwkr7IDHXbRTtZU46+03+5It1tmmquUjh0o/mtYIrCCJqCoAUQWHX?=
 =?Windows-1252?Q?4b8JD54wDOHmmgCPoMO+suqmSlQgVfaqzfXpaYlNp+pOVi1U9gGJjbXq?=
 =?Windows-1252?Q?T4qyAmBcRmEDI9DQ2aMrjvELadQkzNBY2EKtbDWTTw6gc4R2Nf3bmqHY?=
 =?Windows-1252?Q?s1ceJIzIM4YGcEnJgua3lPUuv/teIpqhWNM7J4CDMiAXC/aHr9COAqJz?=
 =?Windows-1252?Q?nWtxMcjpEEGssG+3L9Lb+4NP1lP1A0bsvRkRLaF/rYfzKO1F+lL3HQKG?=
 =?Windows-1252?Q?EPfMf+68rM+r0LpaD9dhyKC1ju8i8t7mfCNfl5Ul0n6TMLPqnuXDT/n8?=
 =?Windows-1252?Q?FvFXQ7Vm/R+7RPqzcuOXUbHeB1poibGHsm+mFM7wK0j0zp2nC8Y8xCSd?=
 =?Windows-1252?Q?QBej34zLR0406kIuS5Ay6Fl/82C2QN+ay0k2AenFTGZ5Ovf5yUvoM0Lo?=
 =?Windows-1252?Q?sT2yKS1dsw3SQxsbAnIGgI8abtOuGEaf0DnmvpMJn25iy0b/fIU8aG4u?=
 =?Windows-1252?Q?lCXHfNthoYVTWHRHyRGbPePp5j/xkcw46p7al74556uXvauXVjmStlid?=
 =?Windows-1252?Q?MMowPUWGo5xAtuh0qMbJFsuMgiRw2apDzFP2ms7+4Mul4zGBwbQylKFw?=
 =?Windows-1252?Q?BNy53LKFA5Qsjc/+1JHrlhL+L/lPE7x6fVHpbEhfZh6j0J09lLisoUxJ?=
 =?Windows-1252?Q?S68k3yuFGMpuRlXyhP5JndAXHvM5Wfx5lOouQY2WeOqdlX4j+eoeM9J3?=
 =?Windows-1252?Q?unO505uUNELfkmESlsa+bzQeNEudKfLO2w1L3H8/19ZiqKQIqEKYqcZh?=
 =?Windows-1252?Q?eNmmLd60gh2LoxYi2CJnPbo0aX0UE/Omq2CKWzeyCBqYScuJX9nDH+wF?=
 =?Windows-1252?Q?mIPklc1+ZEjLGUkC9A3hj0MjEIbZCd41DuSVtVYVuNlzUd4D8G7wQGpG?=
 =?Windows-1252?Q?hNzJEVWp7qkYb15PG+NaoLN3I8DtxKGaQvYSzR33YaQPKJpF+VoRANJJ?=
 =?Windows-1252?Q?4sjw+kJeBRIKei0BxZp1nhSr++Oac1dIasJT48N2DXo2+hqlB/GW/nBS?=
 =?Windows-1252?Q?H+2ckVixHvaZZVQb77U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a60eebd-cd00-4d76-5f59-08d9a8cfb64d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 07:07:12.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQvU4Uf6M7elkpIgf9JbXRwLFsa8Dfvq0pYm6CXgt6WDWQch4Oxx3eqbvL9GTAw8hdSJqpH+xLWe7wyAjDFMfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3628
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/21 7:43 AM, kernel test robot wrote:
> tree:   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7C30b2f5819d7c4d950b2c08d9a001da9e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637716754948769498%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=yAa9UXhBHt902ARvfVXW6cJVYEe9en9jlEba6yVnmVo%3D&amp;reserved=0 master
> head:   d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7
> commit: 96792fdd77cd19fcf2368e7c19bb8b78557ae425 ASoC: amd: enable vangogh platform machine driver build
> date:   3 weeks ago
> config: x86_64-randconfig-r002-20211103 (attached as .config)
> compiler: clang version 14.0.0 (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fllvm%2Fllvm-project&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7C30b2f5819d7c4d950b2c08d9a001da9e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637716754948769498%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=nLB6CHKLCnmnMEI89CJJIYWRcE0w7d4r5D1hRfdFd6M%3D&amp;reserved=0 264d3b6d4e08401c5b50a85bd76e80b3461d77e6)
> reproduce (this is a W=1 build):
>         wget https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fraw.githubusercontent.com%2Fintel%2Flkp-tests%2Fmaster%2Fsbin%2Fmake.cross&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7C30b2f5819d7c4d950b2c08d9a001da9e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637716754948769498%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=norSmlMW7Enht9P6qvvAhJCcd8jxUjsgKYgK2kNKJAk%3D&amp;reserved=0 -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fid%3D96792fdd77cd19fcf2368e7c19bb8b78557ae425&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7C30b2f5819d7c4d950b2c08d9a001da9e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637716754948769498%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ZoY6kD%2BhGMc1jGMK0Ro9BwhRUcNATHK%2BzECc%2FwQ62go%3D&amp;reserved=0
>         git remote add linus https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7C30b2f5819d7c4d950b2c08d9a001da9e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637716754948769498%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=yAa9UXhBHt902ARvfVXW6cJVYEe9en9jlEba6yVnmVo%3D&amp;reserved=0
>         git fetch --no-tags linus master
>         git checkout 96792fdd77cd19fcf2368e7c19bb8b78557ae425
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> ld.lld: error: undefined symbol: __devm_regmap_init_spi
>    >>> referenced by cs35l41-spi.c:85 (sound/soc/codecs/cs35l41-spi.c:85)
>    >>> soc/codecs/cs35l41-spi.o:(cs35l41_spi_probe) in archive sound/built-in.a
> --
>>> ld.lld: error: undefined symbol: spi_setup
>    >>> referenced by cs35l41-spi.c:62 (sound/soc/codecs/cs35l41-spi.c:62)
>    >>> soc/codecs/cs35l41-spi.o:(cs35l41_spi_otp_setup) in archive sound/built-in.a
>    >>> referenced by cs35l41-spi.c:68 (sound/soc/codecs/cs35l41-spi.c:68)
>    >>> soc/codecs/cs35l41-spi.o:(cs35l41_spi_otp_setup) in archive sound/built-in.a
> --
>>> ld.lld: error: undefined symbol: __spi_register_driver
>    >>> referenced by cs35l41-spi.c:134 (sound/soc/codecs/cs35l41-spi.c:134)
>    >>> soc/codecs/cs35l41-spi.o:(cs35l41_spi_driver_init) in archive sound/built-in.a
> 
Fix was provided by Arnd Bergmann. Below is the patch title.
ASoC: amd: vangogh: add SPI dependency.

Still upstream review is pending.

Thanks,
Vijendar

> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for SND_SOC_CS35L41_SPI
>    Depends on SOUND && !UML && SND && SND_SOC && SPI_MASTER
>    Selected by
>    - SND_SOC_AMD_VANGOGH_MACH && SOUND && !UML && SND && SND_SOC && SND_SOC_AMD_ACP5x && I2C
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.01.org%2Fhyperkitty%2Flist%2Fkbuild-all%40lists.01.org&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7C30b2f5819d7c4d950b2c08d9a001da9e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637716754948769498%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=CmJMchAysPCo54Ryf1Lo1fmFLlI5%2BsBUrXG5TKVxoMA%3D&amp;reserved=0
> 

